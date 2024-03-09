%include "io64.inc"
section .data
STR_INPUT times 3 db 0 ; 1 char input + line feed + null char
section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    PRINT_STRING "Input: "
    GET_DEC 8, rax
    GET_CHAR STR_INPUT ; remove trailing line feed in input
    
    PRINT_STRING "Sequence: "
    PRINT_UDEC 8, rax
    
collatz:
    cmp rax, 1
    jz collatz_end
    
    test rax, 1
    jz even
    jmp odd

even:
    shr rax, 1 ; rax <- rax / 2
    PRINT_STRING ", "
    PRINT_UDEC 8, rax
    jmp collatz

odd:
    lea rax, [rax+2*rax+1] ; rax <- rax * 3 + 1
    PRINT_STRING ", "
    PRINT_UDEC 8, rax
    jmp collatz

collatz_end:
    NEWLINE
    PRINT_STRING "Do you want to continue (Y/N)? "
    GET_STRING STR_INPUT, 3
    CMP byte [STR_INPUT], "Y"
    jz main

finish:
    xor rax, rax
    ret