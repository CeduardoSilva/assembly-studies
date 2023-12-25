; This program should print characters entered
; in loop until the user enters 0.
;
; Instructions to run:
; nasm -f macho64 hello_world.asm
; ld -o hello_world hello_world.o -e _start -static
; ./hello_world

section .data
    nl db 0x0A              ; newline character
    msg db 'Enter a character (0 to exit): ', 0
    msg_len equ $ - msg

section .bss
    char resb 1

section .text
    global _start

_start:
    ; Loop start
loop_start:
    ; Print message to ask for input
    mov rax, 0x2000004      ; syscall number for write
    mov rdi, 1              ; file descriptor 1 is stdout
    lea rsi, [rel msg]      ; load effective address of msg relative to instruction pointer
    mov rdx, msg_len        ; length of the message
    syscall

    ; Read a single character from stdin
    mov rax, 0x2000003      ; syscall number for read
    mov rdi, 0              ; file descriptor 0 is stdin
    lea rsi, [rel char]     ; load effective address of char relative to instruction pointer
    mov rdx, 1              ; read one character
    syscall

    ; Check if the input character is '0'
    movzx rax, byte [rel char] ; move the byte to a register with zero extension
    cmp rax, '0'
    je exit_program

    ; Print the character (ignoring the newline in the buffer)
    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel char]
    mov rdx, 1              ; Print only the first character
    syscall

    ; Print a newline
    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel nl]
    mov rdx, 1
    syscall

    ; Loop back
    jmp loop_start

    ; Exit the program
exit_program:
    mov rax, 0x2000001      ; syscall number for exit
    mov rdi, 0              ; status 0
    syscall
