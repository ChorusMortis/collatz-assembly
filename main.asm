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
    
    test rax, rax
    js negative
    test rax, rax
    jz invalid
    
    PRINT_STRING "Sequence: "
    PRINT_UDEC 8, rax
    
collatz:
    cmp rax, 1
    jz prompt
    
    test rax, 1
    jnz odd
    
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

negative:
    PRINT_STRING "Error: Input cannot be negative"
    jmp prompt

invalid:
    PRINT_STRING "Error: Input cannot be zero, empty, or a string"
    
prompt:
    NEWLINE
    PRINT_STRING "Do you want to continue (Y/N)? "
    GET_STRING STR_INPUT, 3
    CMP byte [STR_INPUT], "Y"
    jz main

finish:
    xor rax, rax
    ret