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

    .globl swap_regs
#if !defined(__APPLE__)
    .type  swap_regs, @function
#endif

// extern void swap_regs(char **current, char **next);
swap_regs:

    // 获取 swap_regs 的第一个参数 char **current
    movl 4(%esp), %ecx

    //  %esp  存储的是当前调用栈的顶部所在的地址；
    // (%esp) 是顶部地址所指向的内存区域存储的值，
    // 将这个值存储为 current 的 return address
    movl (%esp), %eax
    movl %eax, 16(%ecx)

    // 依次将各个寄存器的值存储到 current
    movl %ebp, 12(%ecx)
    movl %esi,  8(%ecx)
    movl %edi,  4(%ecx)
    movl %ebx,  0(%ecx)

    // 获取 swap_regs 的第二个参数 char **next
    movl 8(%esp), %ecx

    //  %esp  存储的是当前调用栈的顶部所在的地址；
    // (%esp) 是顶部地址所指向的内存区域存储的值，
    // 将 next 的 return address 写入到该内存区域
    movl 16(%ecx), %eax
    movl %eax, (%esp)

    // 依次将 next 存储的值写入各个寄存器
    movl 12(%ecx), %ebp
    movl  8(%ecx), %esi
    movl  4(%ecx), %edi
    movl  0(%ecx), %ebx

    ret
