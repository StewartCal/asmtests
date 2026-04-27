BITS 32
global main

extern printf
extern fgets
extern stdin

section .data
    prompt db "Enter a string: ", 0
    fmt_result db "A: %d", 10, "E: %d", 10, "I: %d", 10, "O: %d", 10, "U: %d", 10, 0

section .bss
    buffer resb 100

    count_a resd 1
    count_e resd 1
    count_i resd 1
    count_o resd 1
    count_u resd 1

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

    ; zero counters
    mov dword [count_a], 0
    mov dword [count_e], 0
    mov dword [count_i], 0
    mov dword [count_o], 0
    mov dword [count_u], 0

    mov esi, buffer

check_next_char:
    mov al, [esi]

    cmp al, 0
    je print_results

    ; convert uppercase to lowercase if needed
    cmp al, 'A'
    jl check_vowels
    cmp al, 'Z'
    jg check_vowels
    add al, 32

check_vowels:
    cmp al, 'a'
    je found_a

    cmp al, 'e'
    je found_e

    cmp al, 'i'
    je found_i

    cmp al, 'o'
    je found_o

    cmp al, 'u'
    je found_u

    jmp move_to_next_char

found_a:
    inc dword [count_a]
    jmp move_to_next_char

found_e:
    inc dword [count_e]
    jmp move_to_next_char

found_i:
    inc dword [count_i]
    jmp move_to_next_char

found_o:
    inc dword [count_o]
    jmp move_to_next_char

found_u:
    inc dword [count_u]

move_to_next_char:
    inc esi
    jmp check_next_char

print_results:
    push dword [count_u]
    push dword [count_o]
    push dword [count_i]
    push dword [count_e]
    push dword [count_a]
    push fmt_result
    call printf
    add esp, 24

    mov eax, 0

    pop ebp
    ret