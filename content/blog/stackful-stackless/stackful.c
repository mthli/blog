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

// *(REGS + 0) 存储 ebx
// *(REGS + 1) 存储 edi
// *(REGS + 2) 存储 esi
// *(REGS + 3) 存储 ebp
// *(REGS + 4) 存储 return address
char **MAIN_REGS;
char **FUNC_REGS;

// 切换上下文，具体参见 stackful.s 的注释
extern void swap_regs(char **current, char **next);

// 尝试在这个嵌套函数中切换上下文
void nest() {
    // 暂停 func() 然后切换到 main() 执行
    swap_regs(FUNC_REGS, MAIN_REGS);
}

void func() {
    for (int i = 0; i < 3; i++) {
        printf("func, index: %d\n", i);
        nest(); // 尝试在这个嵌套函数中切换上下文
    }
}

int main() {
    // 初始化 main() 的上下文存储空间
    MAIN_REGS = malloc(sizeof(char *) * 5);
    memset(MAIN_REGS, 0, sizeof(char *) * 5);
    // 一开始将 main() 的入口地址放在 return address 上
    *(MAIN_REGS + 4) = (char *) main;

    // 初始化 func() 的上下文存储空间
    FUNC_REGS = malloc(sizeof(char *) * 5);
    memset(FUNC_REGS, 0, sizeof(char *) * 5);
    // 一开始将 func() 的入口地址放在 return address 上
    *(FUNC_REGS + 4) = (char *) func;

    for (int i = 0; i < 3; i++) {
        printf("main, index: %d\n", i);
        // 暂停 main() 然后切换到 func() 执行
        swap_regs(MAIN_REGS, FUNC_REGS);
    }

    return 0;
}
