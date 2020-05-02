---
title: 使用 C 语言实现协程
date: '2020-04-16T16:34:05+00:00'
description: 一种基于达夫设备的思想实现的协程。
---

本文译自 PuTTY 的作者 Simon Tatham 的文章 [Coroutines in C](https://www.chiark.greenend.org.uk/~sgtatham/coroutines.html)，作者在文中介绍了一种基于 [达夫设备](https://mthli.xyz/duff-device/) 的思想实现的协程。注意，*斜体部分为翻译过程中的补充*。考虑到译者的英文水平有限，部分语句的翻译与原文略有出入，强烈建议读者结合原文观看。

## 介绍

编写大型程序总是一件困难的事。其中常见的一个问题就是：如果你有一段代码正在生产数据，同时有另一段代码正在消费这些数据，它俩之间谁应该是 caller（调用者）谁应该是 callee（被调用者）呢*（译者注，即如何维护它俩之间的调用关系）*？

这里有一段非常简单的 decompressor 代码，以及一段非常简单的 parser 代码：

```c
// decompressor
while (1) {
    c = getchar();
    if (c == EOF) break;
    if (c == 0xFF) {
        len = getchar();
        c = getchar();
        while (len--) {
            emit(c);
        }
    } else {
        emit(c);
    }
}
emit(EOF);

// parser
while (1) {
    c = getchar();
    if (c == EOF) break;
    if (isalpha(c)) {
        do {
            add_to_token(c);
            c = getchar();
        } while (isalpha(c));
        got_token(WORD);
    }
    add_to_token(c);
    got_token(PUNCT);
}
```

两段代码都非常简单易懂。前者通过调用 `emit()` 每次产生一个字符；后者通过调用 `getchar()` 每次消费一个字符。只需要调用 `emit()` 和 `getchar()` 就可以传送数据了，所以 decompressor 产生的数据可以很轻易地传送到 parser 中。

在很多现代操作系统中，你可以在两个进程或线程之间使用管道 (pipe) 传输数据。在 decompressor 的 `emit()` 向管道中写数据，在 parser 的 `getchar()` 从同一个管道中读数据。简单粗暴，同时也非常繁琐和浪费性能。尤其是在你不想因为要做类似的事就得把程序拆分为多线程时。

在本篇文章中，我为这类结构性问题提供一种极具创造性的解决方案。

## 重写

一种常见的解决方案是重写通信渠道两端中的一端，使之成为一个可以被调用的函数。以下分别是 decompressor 和 parser 可能会被重写成的样子：

```c
// 如果是 decompressor 被重写
int decompressor(void) {
    static int repchar;
    static int replen;
    if (replen > 0) {
        replen--;
        return repchar;
    }
    c = getchar();
    if (c == EOF) return EOF;
    if (c == 0xFF) {
        replen = getchar();
        repchar = getchar();
        replen--;
        return repchar;
    } else {
        return c;
    }
}

// 如果是 parser 被重写
void parser(int c) {
    static enum {
        START, IN_WORD
    } state;

    switch (state) {
        case IN_WORD:
        if (isalpha(c)) {
            add_to_token(c);
            return;
        }
        got_token(WORD);
        state = START;
        /* fall through */

        case START:
        add_to_token(c);
        if (isalpha(c)) {
            state = IN_WORD;
        } else {
            got_token(PUNCT);
        }
        break;
    }
}
```

当然，你不用把 decompressor 和 parser 都重写了，只用重写其中一个即可。如果是像上述代码那样重写 decompressor，即每次调用会返回一个字符，那么只需要在原来的 parser 代码中将 `getchar()` 替换为 `decompressor()` 即可。反之，如果是像上述代码那样重写 parser，即每次调用都会消费一个字符，那么只需要在原来的 decompressor 代码中将 `emit()` 替换为 `parser()` 即可。

关键点就在于，无论是重写哪一个，相对于原来的代码而言都相当丑陋。无论是 decompressor 还是 parser 作为 caller 而不是 callee 时，代码都更容易被理解。无论是 decompressor 解压数据还是 parser 解析数据，你都会发现原来的代码更简洁清晰。如果我们不需要重写它们其中任何一个就好了。除非你有强迫症才会想把二者都重写了。

## Knuth 的协程

在 [The Art of Computer Programming](https://www-cs-faculty.stanford.edu/~knuth/taocp.html) 这本书中，Donald Knuth 提供了一种此类问题的解决方案。他的回答是完全地抛开调用栈的概念。请停止这种一个程序是 caller 而另一个程序是 callee 的思想，并开始把他们想象为平等的协作者。

实际来说就是将传统的 call 原语替换为一种略微不同的方式。新的 call 原语会将返回值存储在栈之外的某个地方，然后会跳转到另一个已经保存的返回值中的指定位置。即每当 decompressor 生产了一个字符，它便会保存自己的程序计数器，然后跳转到 parser 中最后一次已知的位置；每当 parser 需要一个新的字符时，它便会保存自己的程序计数器，然后跳转到 decompressor 保存的位置。控制程序会根据需要在二者间来回穿梭。

这是一个非常棒的理论，但是你只能使用汇编语言这么干，因为常见的高级语言都不支持这种协程式的 call 原语。像 C 这种语言完全依赖于它们自己的栈调用结构，所以只要控制权从一个函数传递到另一个函数，那么它们中必然有一个是 caller，而另一个必然是被 callee。如果你想撰写可移植的代码，那这至少和使用 Unix 管道的方案一样不切实际。

## 基于栈的协程

所以我们真正需要的是能在 C 语言层面能够模拟 Knuth 的协程的 call 原语的能力。当然我们必须接受这样一个事实，在 C 语言层面，一个函数必然是 caller，而其他函数则是 callee。对于 caller 而言，我们没有任何问题；我们像原本那样写代码就行，当生产出（或者需要）一个字符时，直接调用其他函数就行。

问题集中在 callee 这边。对于 callee 而言，我们需要一种「返回且继续」(return and continue) 的操作：从一个函数中返回，且当这个函数下次被调用时，从它上一次返回之后的地方开始执行。举个例子，就像我们需要实现这样一个函数：

```c
int function(void) {
    int i;
    for (i = 0; i < 10; i++) {
        return i; // 实际上没用，但是适合用来举例子
    }
}
```

调用 10 次这个函数，会得到 0 ~ 9 的返回值。

所以我们要怎么实现这个函数呢？当然我们可以使用 goto 关键字来切换控制流。我们可以声明一个 `state` 变量然后这么做：

```c
int function(void) {
    static int i, state = 0;
    switch (state) {
        case 0: goto LABEL0;
        case 1: goto LABEL1;
    }
    LABEL0: // 函数开始执行
    for (i = 0; i < 10; i++) {
        state = 1; // 我们会跳转到 LABEL1
        return i;
        LABEL1:; // 从上一次返回之后的地方开始执行
    }
}
```

然后就可以了。我们需要在可能恢复控制流的地方设置 label：一个在函数的开头，另一个在 return 之后。我们使用一个 `state` 变量来保存函数调用的状态*（译者注，虽然 `state` 是在函数中被定义的，但它是一个 static 变量，只会被初始化一次，且生命周期超越了函数本身）*，它告诉我们应该使用哪个 label 来恢复控制流。在第一次 return 之前，我们将正确的 label 赋值给 `state` ；在之后任意次调用开始时，我们使用 switch 来决定该跳转到哪里。

不过这看起来依然很丑陋。最糟糕的地方在于，你需要手动地设置 label，并且需要保持 switch 语句和函数体的一致性。每当我们新增一个返回语句，我们都得新增一个 label 然后把它加入到 switch 中；每当我们删除一个返回语句，我们又得删除掉它对应的 label。这使得我们需要付出成倍的工作量。

## 达夫设备

著名的达夫设备 (Duff's Device) 代码片段揭示了 C 语言的这样一个事实，即 case 语句在子代码块中仍然可以和 switch 语句相匹配*（译者注，关于达夫设备的介绍可参见译者的另一篇文章 [深入理解达夫设备](https://mthli.xyz/duff-device/)）*。Tom Duff 使用这个技巧来优化循环展开的逻辑：

```c
switch (count % 8) {
    case 0: do { *to = *from++;
    case 7:      *to = *from++;
    case 6:      *to = *from++;
    case 5:      *to = *from++;
    case 4:      *to = *from++;
    case 3:      *to = *from++;
    case 2:      *to = *from++;
    case 1:      *to = *from++;
            } while (--n > 0);
}
```

我们可以将其改造并应用到协程的实现中。我们可以使用 switch 语句直接实现跳转而不是使用它来决定该执行哪条 goto 语句：

```c
int function(void) {
    static int i, state = 0;
    switch (state) {
        case 0: // 函数开始执行
        for (i = 0; i < 10; i++) {
            state = 1; // 我们会回到 "case 1" 的地方
            return i;
            case 1:; // 从上一次返回之后的地方开始执行
        }
    }
}
```

看起来不错。现在我们需要做的就是构造一些精选的宏，这样我们就能以合理的方式将血腥的 (gory) 细节隐藏起来：

```c
#define crBegin static int state=0; switch(state) { case 0:
#define crReturn(i,x) do { state=i; return x; case i:; } while (0)
#define crFinish }
int function(void) {
    static int i;
    crBegin;
    for (i = 0; i < 10; i++) {
        crReturn(1, i);
    }
    crFinish;
}
```

（注意，使用 `do ... while(0)` 可以确保当 `crReturn` 位于 `if ... else` 之间时，不需要用大括号将其扩起来）

这差不多就是我们想要的样子了。我们可以使用 `crReturn` 实现从函数中返回且下次调用时能从上一次返回之后的地方开始执行。当然啦我们必须遵循一些使用规则（必须使用 `crBegin` 和 `crFinish` 将函数体包围；将所有在多次函数调用过程中需要保持的变量声明为 static 的；永远不要将 `crReturn` 和 switch 语句一起使用）；不过这些规则并没有太限制到我们。

现在唯一的问题就是 `crReturn` 的第一个参数。就像之前我们声明新 label 时需要避免和任何已有的 label 产生冲突那样，我们需要确保所有 `crReturn` 中的 `state` 参数都不一样。如果不这么做的话，编译器就会报错。

但这个问题也是可以被解决的。ANSI C 提供了一个名为 `__LINE__` 的特殊的宏，代表了当前代码所在的行数。所以我们可以把 `crReturn` 重写为：

```c
#define crReturn(x) do { state=__LINE__; return x; \
                         case __LINE__:; } while (0)
```

于是我们再也不需要关心 `state` 参数了，只是我们需要遵守第四条规则（永远不要将两个 `crReturn` 语句写在同一行）。

## 评估

现在我们有了一个可怕的工具，让我们用它把原来的代码重写一下看看。

```c
int decompressor(void) {
    static int c, len;
    crBegin;
    while (1) {
        c = getchar();
        if (c == EOF) break;
        if (c == 0xFF) {
            len = getchar();
            c = getchar();
            while (len--) {
                crReturn(c);
            }
        } else {
            crReturn(c);
        }
    }
    crReturn(EOF);
    crFinish;
}

void parser(int c) {
    crBegin;
    while (1) {
        // 第一个字符已经存储在 c 中了
        if (c == EOF) break;
        if (isalpha(c)) {
            do {
                add_to_token(c);
                crReturn( );
            } while (isalpha(c));
            got_token(WORD);
        }
        add_to_token(c);
        got_token(PUNCT);
        crReturn( );
    }
    crFinish;
}
```

我们把 decompressor 和 parser 都重写为了 callee，但显然并不需要像之前重写的那样需要大规模重组代码。新的代码结构简直就是原始的代码结构的镜像。与晦涩难读的状态机代码相比，读者可以很轻易分辨出 decompressor 解压数据的逻辑和 parser 解析数据的逻辑。一旦你将心智模型迁移到新的模式上，控制流就很简单了：当 decompressor 有一个字符时，它便将其使用 `crReturn` 返回，并且等待在下一次需要字符时被调用。当 parser 需要一个新字符时，它便使用 `crReturn` 返回，并且等待有新字符时被再次调用，新字符以参数 `c` 的形式传入。

但仍然有一些小的结构上的变化：`parser()` 现在将它自己的 `getchar()`（好吧，其实被改为了 `crReturn` ）从循环开始的地方移动到了循环结束的地方，这是因为第一个字符已经以参数 `c` 的形式被传入到函数中了。我们可以接受这种改变，不过如果你真的介意这种改变的话，我们可以强制要求在开始给 `parser()` 输入字符之前要先初始化。

就像之前说的那样，我们没有必要使用这些协程宏把两段代码都重写了。重写其中一个即可，另一个则作为 caller 存在。

现在可以确定的是我们已经达到了我们的目标：一份不需要将生产者或是消费者重写为状态机就可以移植的 ANSI C 代码。通过使用 C 语言预处理器和 switch 语句一个很少被使用到的特性，我们得以实现一个隐式的状态机。

## 编程规范

显然，这个技巧违背了所有书中提到的编程规范。如果你在公司这么写代码，就算你没有被处分，也会被严厉警告！你在宏里嵌入了没有匹配的大括号，在子代码块中使用 case，以及具有可怕破坏性的 `crReturn` 宏⋯⋯很难想象你还没有因为这种不负责任的编码实践而被开除。你应该对自己感到羞耻。

但我声明在此处，这些编程规范都是无效的。我在本文中举的例子不是很长，也不是很复杂，并且在被重写为状态机时也仍然是可理解的。但随着函数变得更长，重写的复杂度也会随之增加，同时清晰度也会下降得非常糟糕。

思考一下。一个由如下代码块组成的函数：

```c
case STATE1:
// DO SOMETHING
if (condition) state = STATE2; else state = STATE3;
```

和一个由如下代码块组成的函数：

```c
LABEL1:
// DO SOMETHING
if (condition) goto LABEL2; else goto LABEL3;
```

对读者来说，看起来可能是差不多。

虽然前者是 caller 后者是 callee，但它们在视觉结构上都是一致的，且它们在底层算法的实现上也是一致的。如果一个人会因为使用了我提供的协程宏而开除你，那他同样也会因为你使用 goto 语句构造小的代码块而开除你！不过这一次他们显然是正确的，因为后者会严重损坏算法的结构性。

代码规范的目标是清晰度。通过将 switch, return, case 语句隐藏在令人困惑的宏里，代码规范会认为你隐藏了程序的语法结构，违反了清晰度要求。但是你又不得不为了揭示读者可能想知道的程序算法结构而这么做！

任何以坚持语法清晰度为代价的代码规范都应该被重写。请在你的雇主因为你使用这个技巧而要开除你时，把这句话告诉他们。

## 精炼和编码

在一个严肃的应用中，这个玩具协程实现基本是不可用的，因为它依赖 static 变量，所以在多线程环境下会重入失效。理想情况下，在一个真实的应用里，你可能会想要在不同上下文中调用同一个函数，并且对于相同上下文中的调用，都应该在相同上下文的最后一次返回之后恢复控制。

当然这解决起来也很简单了。我们需要一个额外的函数参数，它是一个指向当前上下文结构的指针；我们在这种结构中定义所有本地变量，以及我们的协程 `state` 变量。

这看上去是有点丑，因为突然之间你就得使用 `ctx -> i` 作为循环计数器了，而不是像之前那样简单使用 `i` 即可；实际上你定义的所有变量都成为了协程上下文结构的一部分。但它解决了重入问题，并且也没有破坏代码结构。

（当然啦，如果 C 语言有 Pascal 的 with 语句的话，我们就能使用宏将这一层间接寻址隐藏掉。真可惜。不过至少 C++ 程序员们可以通过类来隐式划分作用域，将协程和所有本地变量都作为类的成员来解决）

这里有一份包含了预先定义好的协程宏的 C 语言头文件。文件中定义了两组宏，前缀分别是 `scr` 和 `ccr` 。`scr` 宏是本文中介绍的较为简单的宏实现，你可以和 static 变量搭配使用；`ccr` 宏则提供了可重入机制。完整的文档请参见头文件中的注释。

请注意，Visual C++ 6.0 看起来不太喜欢这种协程技巧，因为它默认的调试功能 (Program Database for Edit and Continue) 和 `__LINE__` 宏搭配在一起时，会表现出奇怪的行为。如果你想要使用 VC++ 6.0 编译包含协程的程序，你必须关掉 Edit and Continue 功能（在 Project Settings 里，点击 C/C++ 标签，接着点击 General 再点击 Debug info。随便选择一个除了 "Program Database for Edit and Continue" 之外的选项）。

（这份头文件遵循 MIT 协议，所以你可以不受限制地在任何地方使用。如果你觉得 MIT 协议不适用于你要做的事，[给我发邮件吧](mailto://anakin@pobox.com)，我大概会给授予你额外的权限去做这件事）

[猛击这个链接](https://www.chiark.greenend.org.uk/~sgtatham/coroutine.h) 获取 coroutine.h。

感谢阅读！我很享受这种分享的状态。

## 引用

- Donald Knuth, The Art of Computer Programming, Volume 1. Addison-Wesley, ISBN 0-201-89683-4. Section 1.4.2 describes coroutines in the "pure" form.
- http://www.lysator.liu.se/c/duffs-device.html 指向了 Tom Duff 自己对达夫设备的讨论。请注意，在讨论的底部，达夫可能已经独立发明了这种协程技巧，或者某种类似的东西。**Update, 2005-03-07：**达夫在一篇博客的评论中 [确认了这件事](http://brainwagon.org/2005/03/05/coroutines-in-c/#comment-1878) 。他所说的「使用 switch 的方式来实现状态机的中断」和我在文中所述的技巧是一样的。
- [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) 是一个 Win32 平台下的 Telnet 和 SSH 客户端。其中 SSH 协议的代码实现就真实使用到了这种协程技巧。至少在我看来，这是我见过的在一个严肃的产品中使用过的最糟糕的 C 语言特性了。
