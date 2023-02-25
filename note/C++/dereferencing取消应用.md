// four bytes with the numerical values used to encode the letters 'a', 'b', 'b',
// numerival : 数字的
// letter : 字母、信
// 四字节的数字值用于编码字母abc
// 0 byte to denote the end of the textual data
// denote : 意味着。表示
// textual : 文本的
// 0字节意味着文本数据的结束




#include <stdio.h>
/*
    https://www.codenong.com/4955198/
    取消对指针的引用意味着获取存储在指针指向的内存位置中的值。运算符*用于执行此操作，称为解引用运算符。
*/
int main() {
    int a = 10;
    int* ptr = &a;

    printf("%d", *ptr); // With *ptr I'm dereferencing the pointer.
                        // Which means, I am asking the value pointed at by the pointer.
                        // ptr is pointing to the location in memory of the variable a.
                        // In a's location, we have 10. So, dereferencing gives this value.

    // Since we have indirect control over a's location, we can modify its content using the pointer. This is an indirect way to access a.

    *ptr = 20;         // Now a's content is no longer 10, and has been modified to 20.
};
