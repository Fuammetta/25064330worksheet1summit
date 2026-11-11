
%include "asm_io.inc"

global asm_main

segment .data
    array:
    %assign i 1
    %rep 100
        dd i
        %assign i i+1
    %endrep

    msg1 db "Enter starting number (1-100): ", 0
    msg2 db "Enter ending number (1-100): ", 0
    msg3 db "Sum: ", 0
    error_msg db "Invalid range! Please enter numbers between 1 and 100, with start <= end.", 10, 0

segment .bss
    start_num resd 1
    end_num resd 1
    total resd 1

segment .text
    global asm_main

asm_main:
    pusha

    ; Ask for starting number
    mov eax, msg1
    call print_string
    call read_int
    mov [start_num], eax

    ; Check starting number
    cmp eax, 1
    jl invalid
    cmp eax, 100
    jg invalid

    ; Ask for ending number
    mov eax, msg2
    call print_string
    call read_int
    mov [end_num], eax

    ; Check ending number
    cmp eax, 1
    jl invalid
    cmp eax, 100
    jg invalid

    ; Check starting number <= ending number
    mov eax, [start_num]
    cmp eax, [end_num]
    jg invalid

    ; Calculate the sum
    mov ecx, [start_num]
    xor ebx, ebx

sum_loop:
    cmp ecx, [end_num]
    jg sum_done

    ; Array uses 0-based indexing
    mov eax, ecx
    dec eax
    add ebx, [array + eax*4]

    inc ecx
    jmp sum_loop

sum_done:
    mov [total], ebx

    ; Display result
    mov eax, msg3
    call print_string

    mov eax, [total]
    call print_int
    call print_nl

    jmp program_done

invalid:
    mov eax, error_msg
    call print_string

program_done:
    popa
    mov eax, 0
    ret
