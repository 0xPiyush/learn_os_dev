mov ah, 0x0e
mov al, 'A'
int 0x10

alphabet:
    inc al
    cmp al, 'z' + 1
    je exit
    cmp al, 'Z' + 1
    je exit
    jl print_small
    jmp print_caps
    jmp alphabet

print_caps:
    sub al, 32
    int 0x10
    jmp alphabet

print_small:
    add al, 32
    int 0x10
    jmp alphabet

exit:
    jmp $

times 510 - ($ - $$) db 0
db 0x55, 0xaa