[org 0x7c00]

mov ah, 0x0e ; Enable TTY Mode
printInputPrompt:
    mov bx, inputPrompt
    print_loop:
        mov al, [bx]
        cmp al, 0
        je printInputPrompt_end
        int 0x10
        inc bx
        jmp print_loop
printInputPrompt_end:
    jmp readInput

readInput:
    mov ah, 0
    int 0x16
    jmp processInput

processInput:
    cmp al, 13
    je enter_pressed

    cmp al, 8
    je backspace_pressed

    jmp display_input

display_input:
    ; Display the typed character
    mov ah, 0x0e
    int 0x10
    ; Add the character to the buffer
    mov [bx], al
    inc bx
    jmp readInput

enter_pressed:
    mov bx, inputBuffer
    mov al, [bx]
    cmp al, 0
    je readInput
    mov ah, 0x0e ; Enable TTY Mode
    mov al, 13 ; Print a Carriage Return
    int 0x10
    mov al, 10 ; Print a Line Feed
    int 0x10
    dec bx
    jmp printInput

backspace_pressed:
    ; Still need to implement this
    jmp backspace_pressed_end
backspace_pressed_end:
    jmp readInput

printInput:
    mov al, [bx]
    cmp al, 0
    je printInput_end
    int 0x10
    inc bx
    jmp printInput
printInput_end:
    mov cx, 0 ; counter
    mov al, 0
    mov bx, inputBuffer
    dec bx
    resetInputBuffer:
        cmp cx, 9
        je resetInputBuffer_end
        mov [bx], al
        inc bx
        inc cx
    resetInputBuffer_end:
    mov al, 13 ; Print a Carriage Return
    int 0x10
    mov al, 10 ; Print a Line Feed
    int 0x10
    jmp printInputPrompt


inputPrompt:
    db "Enter a String and I will echo it (10 Characters): ", 0

inputBuffer:
    times 10 db 0

; Create the boot sector
times 510 - ($ - $$) db 0
dw 0xaa55