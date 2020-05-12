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

// *(CTX + 0) 存储 return address
// *(CTX + 1) 存储 ebx
// *(CTX + 2) 存储 edi
// *(CTX + 3) 存储 esi
// *(CTX + 4) 存储 ebp
// *(CTX + 5) 存储 esp
char **MAIN_CTX;
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
    // 将 func 的地址作为栈帧 return address 的初始值
    *(ctx + 0) = (char *) func;
    // 将 ctx 的内存地址作为栈帧顶部地址的初始值
    *(ctx + 5) = (char *) ctx;
    return ctx;
}

// 因为我们只有三个协程（其中一个是主协程，
// 所以这里简单用 switch 来模拟调度器切换上下文了
void yield() {
    switch ((YIELD_COUNT++) % 3) {
    case 0:
        swap_ctx(MAIN_CTX, FUNC_CTX_1);
        break;
    case 1:
        swap_ctx(FUNC_CTX_1, FUNC_CTX_2);
        break;
    case 2:
        swap_ctx(FUNC_CTX_2, MAIN_CTX);
        break;
    default:
        // DO NOTHING
        break;
    }
}

void func() {
    int tag = rand() % 100;
    for (int i = 0; i < 3; i++) {
        printf("func, tag: %d, index: %d\n", tag, i);
        yield();
    }
}

int main() {
    MAIN_CTX = init_ctx((char *) main);
    FUNC_CTX_1 = init_ctx((char *) func);
    FUNC_CTX_2 = init_ctx((char *) func);

    int tag = rand() % 100;
    for (int i = 0; i < 3; i++) {
        printf("main, tag: %d, index: %d\n", tag, i);
        yield();
    }

    return 0;
}
