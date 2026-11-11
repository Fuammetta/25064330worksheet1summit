
%include "asm_io.inc"

segment .data
    msg db "Sum of array: ", 0

    array:
    %assign i 1
    %rep 100
        dd i
        %assign i i+1
    %endrep

segment .text
    global asm_main

asm_main:
    pusha

    mov ebx, 0          ; EBX stores the total
    mov ecx, 0          ; ECX stores the array index

sum_loop:
    cmp ecx, 100        ; Have we reached 100 numbers?
    jge sum_done

    add ebx, [array + ecx*4] ; Add current array number
    inc ecx             ; Move to the next number

    jmp sum_loop

sum_done:
    mov eax, msg
    call print_string

    mov eax, ebx        ; Put total into EAX
    call print_int      ; Display total
    call print_nl       ; New line

    popa
    mov eax, 0
    ret
