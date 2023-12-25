; This program should print characters entered
; in loop until the user enters 0.
;
; Instructions to run:
; nasm -f macho64 hello_world.asm
; ld -o hello_world hello_world.o -e _start -static
; ./hello_world

section .data
    msg db 'Enter an operand and two numbers (+, -, x, /, +21): ', 0
    msg_len equ $ - msg

section .bss
    oper resb 1
    num1 resb 1
    num2 resb 1
    resp resb 1

section .text
    global _start

_start:
    mov rax, 0x2000004      ; syscall number for write
    mov rdi, 1              ; file descriptor 1 is stdout
    lea rsi, [rel msg]      ; load effective address of msg relative to instruction pointer
    mov rdx, msg_len        ; length of the message
    syscall

    ; Read 1 character from stdin
    mov rax, 0x2000003      ; syscall number for read
    mov rdi, 0              ; file descriptor 0 is stdin
    lea rsi, [rel oper]     ; load effective address of char relative to instruction pointer
    mov rdx, 1              ; read one character        
    syscall

    ; Read 1 character from stdin
    mov rax, 0x2000003      ; syscall number for read
    mov rdi, 0              ; file descriptor 0 is stdin
    lea rsi, [rel num1]     ; load effective address of char relative to instruction pointer
    mov rdx, 1              ; read one character           
    syscall

    ; Read 1 character from stdin
    mov rax, 0x2000003      ; syscall number for read
    mov rdi, 0              ; file descriptor 0 is stdin
    lea rsi, [rel num2]     ; load effective address of char relative to instruction pointer
    mov rdx, 1              ; read one character           
    syscall
    
    ; Check if the input character is '0'
    ;movzx rax, byte [rel char] ; move the byte to a register with zero extension
    ;cmp rax, '0'
    ;je exit_program

    ; Sum operation
    mov eax, 0
    mov [rel resp], eax
    mov eax, [rel num1]
    mov ebx, [rel num2]
    add ebx, [rel num1]
    mov [rel resp], ebx

    ; Print the result
    mov rax, 0x2000004
    mov rdi, 1
    lea rsi, [rel resp]
    mov rdx, 1              ; Print only the first character
    syscall

    ; Exit the program
exit_program:
    mov rax, 0x2000001      ; syscall number for exit
    mov rdi, 0              ; status 0
    syscall
