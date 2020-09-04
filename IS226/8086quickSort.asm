data segment
   a dw 0050H, 0049H, 0048H, 0047H, 0046H, 0045H, 0044H, 0043H, 0042H, 0041H, 0040H, 0039H, 0038H, 0037H, 0036H, 0035H, 0034H, 0033H, 0032H, 0031H, 0030H, 0029H, 0028H, 0027H, 0026H, 0025H, 0024H, 0023H, 0022H, 0021H, 0020H, 0019H, 0018H, 0017H, 0016H, 0015H, 0014H, 0013H, 0012H, 0011H, 0010H, 0009H, 0008H, 0007H, 0006H, 0005H, 0004H, 0003H, 0002H, 0001H
data ends

stack segment
    ST   db   200dup(0)
    TOP  EQU  200H
stack ends

code segment
    assume cs:code, ds:data, ss:stack
start:
    mov ax, stack
    mov ss, ax
    mov sp, TOP
    
    push ds
    xor ax, ax
    push ax
    
    mov ax, data
    mov ds, ax
    
    call quicksort_wrapper
    
    mov ax, 4c00h ; exit to operating system.
    int 21h       


quicksort_wrapper proc near
        mov si, offset a
        mov di, 64H
        sub di, 02H
        
        call quicksort
        
        ret
quicksort_wrapper endp 
        
            
quicksort proc near    
        cmp si, di
        jnl END_QUICKSORT
        push di
        push si
        call quickpass
    
        pop di
        pop si
        push di
        sub di, 02H
        cmp si, di
        JL IF_TO
        JNL ELSE_TO
    
    IF_TO:
        call quicksort
    
    ELSE_TO:
        pop si
        pop di
        add si, 02H
        cmp si, di
        jnl END_QUICKSORT
        call quicksort
        
    END_QUICKSORT:
        ret
        
quicksort endp        


quickpass proc near
        pop bx
        pop si
        pop di
        push di
        push si
        mov dx, word ptr[si]
        
    LOOP_OUT:
        cmp si, di
        jnb END_QUICKPASS    
        
    LOOP_IN1:
        cmp si, di
        jnl LOOP_IGNORE_IN1
        cmp word ptr[di], dx
        jng LOOP_IGNORE_IN1
        sub di, 02H
        jmp LOOP_IN1
        
    LOOP_IGNORE_IN1:
        cmp si, di
        jnl LOOP_IN2
        mov ax, word ptr[di]
        mov [si], ax
    
    LOOP_IN2:
        cmp si, di
        jnl LOOP_IGNORE_IN2
        cmp word ptr[si], dx
        jnl LOOP_IGNORE_IN2
        add si, 02H
        jmp LOOP_IN2
    
    LOOP_IGNORE_IN2:
        cmp si, di
        jnl LOOP_IN_END
        mov ax, word ptr[si]
        mov [di], ax
    
    LOOP_IN_END:
        jmp LOOP_OUT 
        
    END_QUICKPASS:
        mov [si], dx
        push si
        push bx
        ret
quickpass endp

ends

end start 
