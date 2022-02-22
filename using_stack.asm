mov bp, 0x8000 ; Set position of stack base pointer
mov sp, bp ; Set position of stack pointer to the same

mov bh, 'A'
push bx

mov bh, 'B'
mov ah, 0x0e
mov al, bh
int 0x10

jmp $

; Create the boot sector
times 510 - ($ - $$) db 0
dw 0xaa55