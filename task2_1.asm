
%include "asm_io.inc"

global asm_main

segment .data
    msg1 db "Enter your name: ", 0
    msg2 db "Enter a number (51-99): ", 0
    welcome db "Welcome, ", 0
    ending db "!", 10, 0
    error_msg db "Error! Number must be between 51 and 99.", 10, 0

segment .bss
    name resb 50

segment .text
    global asm_main

asm_main:
    pusha

    ; Ask for name
    mov eax, msg1
    call print_string

    xor ecx, ecx

read_name:
    call read_char

    cmp al, 10
    je name_done

    cmp al, 13
    je name_done

    cmp ecx, 49
    jae read_name

    mov [name + ecx], al
    inc ecx
    jmp read_name

name_done:
    mov byte [name + ecx], 0

    ; Ask for number
    mov eax, msg2
    call print_string

    call read_int

    ; Check number
    cmp eax, 50
    jle error

    cmp eax, 100
    jge error

    ; Print welcome message
    mov ebx, eax

welcome_loop:
    mov eax, welcome
    call print_string

    mov eax, name
    call print_string

    mov eax, ending
    call print_string

    dec ebx
    jnz welcome_loop

    jmp done

error:
    mov eax, error_msg
    call print_string

done:
    popa
    mov eax, 0
    ret
