    .model small
    .data
    .code
    public _tree
    ;
First MACRO L, start, last
L:  mov DL, 2Eh
    INT 21h
    INC start
    CMP last, start
    JNZ L
ENDM

Tree MACRO L, start
    mov start, CX    
    SUB start, 1
    SHL start, 1
    ADD start, 1
    
L:  mov DL, 2Ah
    INT 21h
    DEC start
    CMP start, 0
    JNE L
ENDM

Second MACRO L, start, last
L:  mov DL, 2Dh
    INT 21h
    INC start
    CMP last, start
    JNZ L
ENDM

_tree PROC NEAR
    ;
    push BP
    mov BP, SP
    push DX
    xor CX, CX
    xor DX, DX
    mov DI, 40
    xor SI, SI
    mov AH, 2
    ;
    
st1:INC CX 
    First L1, SI, DI
    ;
    DEC DI
    xor SI, SI
    
    ;
    Tree L2, SI
    ;
    xor SI, SI
    ;
    Second L3, SI, DI
    ;
    MOV DL, 0Dh
    INT 21h
    
    xor SI, SI
    mov DX, [BP+4]
    CMP CX, DX
    JNE st1
    ;
    
    SHR CX, 1
    mov BX, CX
    mov SI, CX    
    SUB SI, 1
    SHL SI, 1
    ADD SI, 1
    
    SHR SI, 1
    mov DI, 40
    SUB DI, SI
    xor SI, SI
    
st2:First L4, SI, DI
    ;
    DEC DI
    xor SI, SI
    
    Tree L5, SI
    ;
    xor SI, SI
    ;
    Second L6, SI, DI
    ;
    MOV DL, 0Dh
    INT 21h
    
    xor SI, SI
    INC CX
    mov DX, [BP+4]
    ADD DX, BX
    CMP CX, DX
    JNE st2
    ;    
    
    mov DX, [BP+4]
    SHR DX, 1
    mov CX, DX
    mov DI, 40
    ;
st3: First L7, SI, DI
    ;
    
    mov DL, 2Ah
    INT 21h
    ;
    xor SI, SI
    mov SI, 1
    
    Second L8, SI, DI
    
    MOV DL, 0Dh
    INT 21h
    xor SI, SI
    DEC CX
    CMP CX, 0
    JNE st3
    ;
    pop dx
    pop bp
    ret
    ;
_tree ENDP
       END