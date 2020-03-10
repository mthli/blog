---
title: RxJava 链式调用原理
date: "2020-02-13T12:56:41+00:00"
description: RxJava 采用了类似 Stream API 的链式调用设计，提供了 filter, map, observeOn 等常用的的操作符。与 Builder 模式对调用方法的顺序没有要求不同，RxJava 的操作符调用需要保持顺序关系。在本篇文章中，我们来了解一下这种顺序关系是如何实现的。
---

RxJava 采用了类似 Stream API 的链式调用设计，提供了 filter, map, observeOn 等常用的的操作符。与 Builder 模式对调用方法的顺序没有要求不同，RxJava 的操作符调用需要保持顺序关系。在本篇文章中，我们来了解一下这种顺序关系是如何实现的。

一个典型的链式调用场景如下：

```java
Observable
  .create(...)
  .filter(...)
  .map(...)
  .observeOn(...)
  .subscribe(...)
```

链式调用从 `subscribe()` 开始被触发，我们来看一下对应的源码：

```java
public abstract class Observable<T> implements ObservableSource<T> {
  ...
  public final void subscribe(Observer<? super T> observer) {
    ...
    try {
      ...
      subscribeActual(observer); // highlight-line
    } catch (NullPointerException e) { // NOPMD
      throw e;
    } catch (Throwable e) {
      ...
    }
  }

  protected abstract void subscribeActual(
    Observer<? super T> observer);
}
```

可以看到 `subscribe()` 实际调用的是 `subscribeActual()` 的具体实现。而 Observable 的子类有 ObservableFilter, ObservableMap, ObservableObserveOn 等。聪明的你肯定想到了，这些子类显然与对应的操作符有关。以 filter 为例：

```java
public final Observable<T> filter(Predicate<? super T> predicate) {
  ...
  return RxJavaPlugins.onAssembly(
    // highlight-next-line
    new ObservableFilter<T>(this, predicate)
  );
}
```

可以看到，每调用一次 filter 都会将上层的 Observable 包装成一个新的 ObservableFilter. 以此类推，我们最初的例子的调用栈实际上是这样的：

```java
// 最后被执行
ObservableObserveOn.subscribeActual() {
  // 第三个被执行
  ObservableMap.subscribeActual() {
    // 第二个被执行
    ObservableFilter.subscribeActual() {
      // 嵌套最深的最先被执行
      ObservableCreate.subscribeActual() {
        // DO SOMETHING
      }
    }
  }
}
```

看到这里，RxJava 链式调用时仍然能保持顺序关系的原理已经昭然若揭了。至于每个 Observable 都是如何实现的，这里就不展开了，其中涉及 Java 的静态代理，感兴趣的同学可以参见这个知乎回答 [Java 动态代理作用是什么？](https://www.zhihu.com/question/20794107/answer/75164285)
