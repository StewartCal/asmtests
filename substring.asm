section .text
global find_substring

find_substring:
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    mov esi, [ebp+8]      ; main_str
    mov edi, [ebp+12]     ; substr
    mov edx, [ebp+16]     ; &starting_index

    mov ecx, 0            ; i = 0

check_start:
    mov al, [esi + ecx]
    cmp al, 0
    je not_found

    mov eax, ecx          ; save i
    mov ebx, 0            ; j = 0

compare_loop:
    mov dl, [edi + ebx]   ; substr[j]
    cmp dl, 0
    je found

    mov eax, ecx
    add eax, ebx          ; eax = i + j
    mov dh, [esi + eax]   ; main[i + j]

    cmp dh, 0
    je not_found

    cmp dh, dl
    jne next_start

    inc ebx
    jmp compare_loop

next_start:
    inc ecx
    jmp check_start

found:
    mov eax, [ebp+16]
    mov [eax], ecx
    jmp done

not_found:
    mov eax, [ebp+16]
    mov dword [eax], -1

done:
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
