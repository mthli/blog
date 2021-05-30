/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2020 Matthew Lee
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// 编译
// gcc -m32 stackful.c stackful.s

// *(ctx + 0) 存储 return address
// *(ctx + 1) 存储 ebx
// *(ctx + 2) 存储 edi
// *(ctx + 3) 存储 esi
// *(ctx + 4) 存储 ebp
// *(ctx + 5) 存储 esp
char **MAIN_CTX;
char **NEST_CTX;
char **FUNC_CTX_1;
char **FUNC_CTX_2;

// 用于模拟切换协程的上下文
int YIELD_COUNT;

// 切换上下文，具体参见 stackful.s 的注释
extern void swap_ctx(char **current, char **next);

char **init_ctx(char *func) {
    // 动态申请 1kb 内存作为栈帧空间
    size_t size = sizeof(char *) * 1024;
    char **ctx = malloc(size);
    memset(ctx, 0, size);

    // 将 func 的地址作为其栈帧 return address 的初始值，
    // 当 func 第一次被调度时，将从其入口处开始执行
    *(ctx + 0) = (char *) func;

    // 需要预留 6 个寄存器内容的存储空间；
    // 所以栈帧顶部地址的初始值为存储空间地址 + 1
    size = sizeof(char *) * 6 + 1;
    *(ctx + 5) = (char *) (ctx + size);
    return ctx;
}

// 因为我们只有 4 个协程（其中一个是主协程，
// 所以这里简单用 switch 来模拟调度器切换上下文了
void yield() {
    switch ((YIELD_COUNT++) % 4) {
    case 0:
        swap_ctx(MAIN_CTX, NEST_CTX);
        break;
    case 1:
        swap_ctx(NEST_CTX, FUNC_CTX_1);
        break;
    case 2:
        swap_ctx(FUNC_CTX_1, FUNC_CTX_2);
        break;
    case 3:
        swap_ctx(FUNC_CTX_2, MAIN_CTX);
        break;
    default:
        // DO NOTHING
        break;
    }
}

void nest_yield() {
    yield();
}

void nest() {
    // 随机生成一个整数作为 tag
    int tag = rand() % 100;
    for (int i = 0; i < 3; i++) {
        printf("nest, tag: %d, index: %d\n", tag, i);
        nest_yield();
    }
}

void func() {
    // 随机生成一个整数作为 tag
    int tag = rand() % 100;
    for (int i = 0; i < 3; i++) {
        printf("func, tag: %d, index: %d\n", tag, i);
        yield();
    }
}

int main() {
    MAIN_CTX = init_ctx((char *) main);

    // 证明 nest() 可以在其嵌套函数中被挂起
    NEST_CTX = init_ctx((char *) nest);

    // 证明同一个函数在不同的栈帧空间上运行
    FUNC_CTX_1 = init_ctx((char *) func);
    FUNC_CTX_2 = init_ctx((char *) func);

    int tag = rand() % 100;
    for (int i = 0; i < 3; i++) {
        printf("main, tag: %d, index: %d\n", tag, i);
        yield();
    }

    return 0;
}
