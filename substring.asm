section .text
global find_substring

; void find_substring(char *main_str, char *substr, int *starting_index)

find_substring:
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    mov esi, [ebp+8]      ; esi = main_str base address
    mov edi, [ebp+12]     ; edi = substr base address
    mov edx, [ebp+16]     ; edx = &starting_index

    mov ecx, 0            ; ecx = main_index

check_start_position:
    mov al, [esi + ecx]   ; al = main_str[main_index]
    cmp al, 0
    je substring_not_found

    mov eax, ecx          ; eax = saved starting index
    mov ebx, 0            ; ebx = substring_index

compare_at_current_start:
    mov dl, [edi + ebx]        ; dl = substr[substring_index]
    cmp dl, 0
    je substring_found

    mov dh, [esi + ecx + ebx]  ; dh = main_str[main_index + substring_index]
    cmp dh, 0
    je substring_not_found

    cmp dh, dl
    jne move_to_next_start

    inc ebx
    jmp compare_at_current_start

move_to_next_start:
    inc ecx
    jmp check_start_position

substring_found:
    mov edx, [ebp+16]
    mov [edx], eax
    jmp done

substring_not_found:
    mov edx, [ebp+16]
    mov dword [edx], -1

done:
    pop edi
    pop esi
    pop ebx

    pop ebp
    ret
