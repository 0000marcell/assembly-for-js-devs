%macro	ExitProg 0
    mov eax,1		; Code for Exit Syscall
    mov ebx,0		; Return a code of zero	
    int 80H			; Make kernel call
%endmacro

section .data
    newline db 10,0

section .bss
    printSpace resb 8
    digitSpace resb 100
    digitSpacePos resb 8

section .text

global _start
_start:
    mov rdi, qword [rsp + 16] ; Get the third item in the stack
    movzx rax, byte [rdi]   ; Get the first character 
    sub rax, 48             ; Convert from ASCII to decimal
    call Fib ; after call Fib `rbx` has the result
    mov rax, rbx
    call printRAX
    mov rax, newline
    call print
    ExitProg

Fib:
    cmp rax,3
    jl L3 
    push rax
    dec rax
    call Fib
    pop rax
    push rbx
    dec rax  
    dec rax
    call Fib
    pop rcx
    add rbx, rcx
    ret

L3:  
    dec rax
    mov rbx, rax
    ret

print:
    mov [printSpace], rax
    call printLoop
    ret

printLoop:
    mov cl, [rax]
    cmp cl, 0
    je endPrintLoop
    inc rbx
    inc rax
    jmp printLoop

endPrintLoop:
    mov rax, 1 
    mov rdi, 0 
    mov rsi, [printSpace]
    mov rdx, rbx
    syscall
    ret

printRAX:
    mov rcx, digitSpace
    mov [digitSpacePos], rcx

printRAXLoop:
    mov rdx, 0
    mov rbx, 10
    div rbx
    push rax
    add rdx, 48

    mov rcx, [digitSpacePos]
    mov [rcx], dl
    inc rcx
    mov [digitSpacePos], rcx

    pop rax
    cmp rax, 0
    jne printRAXLoop

printRAXLoop2:
    mov rcx, [digitSpacePos]

    mov rax, 1
    mov rdi, 1
    mov rsi, rcx
    mov rdx, 1
    syscall

    mov rcx, [digitSpacePos]
    dec rcx
    mov [digitSpacePos], rcx

    cmp rcx, digitSpace
    jge printRAXLoop2
    ret
