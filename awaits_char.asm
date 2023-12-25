; This program should await for a input
; And then print it on screen.
;
; Instructions to run:
; nasm -f macho64 hello_world.asm
; ld -o hello_world hello_world.o -e _start -static
; ./hello_world

section .data
    msg db 'Enter a character: ', 0
    msg_len equ $ - msg

section .bss
    char resb 1

section .text
    global _start

_start:
    ; Print message to ask for input
    mov rax, 0x2000004      ; syscall number for write
    mov rdi, 1              ; file descriptor 1 is stdout
    mov rsi, msg            ; message to print
    mov rdx, msg_len        ; length of the message
    syscall

    ; Read a single character from stdin
    mov rax, 0x2000003      ; syscall number for read
    mov rdi, 0              ; file descriptor 0 is stdin
    mov rsi, char           ; buffer to store the character
    mov rdx, 1              ; read one character
    syscall

    ; Print the character
    mov rax, 0x2000004      ; syscall number for write
    mov rdi, 1              ; file descriptor 1 is stdout
    mov rsi, char           ; character to print
    mov rdx, 1              ; length is one character
    syscall

    ; Exit the program
    mov rax, 0x2000001      ; syscall number for exit
    mov rdi, 0            ; status 0
    syscall
