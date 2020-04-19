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
#include <time.h>

int main()
{
    int sum = 0;
    clock_t begin = clock();

    // 正常情况下的 for 循环，
    // 需要连续迭代 100000000 次
    for (int i = 0; i < 100000000; i++)
    {
        sum += i;
    }

    clock_t end = clock();
    double duration = (double)(end - begin) / CLOCKS_PER_SEC;
    printf("normal, sum: %d, duration: %f\n", sum, duration);

    sum = 0;
    begin = clock();

    // 每次循环展开 5 次，
    // 只用迭代 20000000 次即可
    for (int i = 0; i < 100000000; i += 5)
    {
        sum += i;
        sum += i + 1;
        sum += i + 2;
        sum += i + 3;
        sum += i + 4;
    }

    end = clock();
    duration = (double)(end - begin) / CLOCKS_PER_SEC;
    printf("unroll, sum: %d, duration: %f\n", sum, duration);

    return 0;
}
