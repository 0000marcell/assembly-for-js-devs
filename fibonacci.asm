global _start
_start:
    mov rax,5
    call Fib 

    ; return control to the OS
    mov eax,1		; Code for Exit Syscall
	  mov ebx,0		; Return a code of zero	
	  int 80H ; Make kernel call
    ret

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
