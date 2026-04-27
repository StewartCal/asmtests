BITS 32
global main

extern printf
extern fgets
extern stdin

section .data
    prompt db "Enter a string: ", 0
    fmt_char db "%c: %d", 10, 0
    newline db 10, 0

section .bss
    buffer resb 100
    freq   resd 26

section .text

main:
    push ebp
    mov ebp, esp

    ; printf("Enter a string: ")
    push prompt
    call printf
    add esp, 4

    ; fgets(buffer, 100, stdin)
    push dword [stdin]
    push dword 100
    push buffer
    call fgets
    add esp, 12

    ; zero freq array
    mov ecx, 26
    mov edi, freq
zero_loop:
    mov dword [edi], 0
    add edi, 4
    loop zero_loop

    ; count frequencies
    mov esi, buffer

count_loop:
    mov al, [esi]
    cmp al, 0
    je print_results

    ; uppercase A-Z → lowercase
    cmp al, 'A'
    jl check_lower
    cmp al, 'Z'
    jg check_lower
    add al, 32

check_lower:
    cmp al, 'a'
    jl next_char
    cmp al, 'z'
    jg next_char

    sub al, 'a'
    movzx eax, al

    mov ebx, [freq + eax*4]
    inc ebx
    mov [freq + eax*4], ebx

next_char:
    inc esi
    jmp count_loop

; print results
print_results:
    mov ecx, 26
    mov ebx, 0          ; index

print_loop:
    push dword [freq + ebx*4]
    mov eax, 'a'
    add eax, ebx
    push eax
    push fmt_char
    call printf
    add esp, 12

    inc ebx
    loop print_loop

    mov eax, 0
    pop ebp
    ret