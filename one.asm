%include "asm_io.inc"

global asm_main

segment .data
    interger1 dd 15
    interger2 dd 6

segment .bss
    result resd 1

segment .text
    global asm_main

asm_main:
    enter 0,0
    pusha
    mov eax, [interger1]
    mov eax, [interger2]
    mov [result], eax
    call print_int
    call print_nl
    popa
    mov eax, 0
    leave
    ret