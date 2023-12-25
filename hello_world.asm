; Instructions to run:
; nasm -f macho64 hello_world.asm
; ld -o hello_world hello_world.o -e _start -static
; ./hello_world

section .data
    hello db 'Hello, worlds!',0

section .text
    global _start

_start:
    mov rax, 0x2000004     ; syscall number for write
    mov rdi, 1             ; file descriptor 1 is stdout
    mov rsi, hello         ; address of string to output
    mov rdx, 13            ; number of bytes
    syscall                ; invoke operating system to do the write

    mov rax, 0x2000001     ; syscall number for exit
    mov rdi, 0           ; status 0
    syscall                ; invoke operating system to exit
