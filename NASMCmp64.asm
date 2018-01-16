%include "io64.inc"

section .data
    git_repo       db      'https://github.com/nerfnet/examplex64/', 0
    empty_field    db      ' ', 0
    
    default_number equ     1 ; set value
    compare_number equ     2 ; set value

section .text
    global CMAIN
    
CMAIN:
    mov              rbp, rsp
    xor              rax, rax
    jmp              boot
    
boot:                ; bootstrap
    mov              rbx, default_number
    mov              rdx, compare_number
    PRINT_STRING     git_repo
    call             _printempty
    jmp              _compare
    
_printempty:
    NEWLINE          
    PRINT_STRING    empty_field
    NEWLINE
    ret
      
_compare:
    cmp              rbx, compare_number
    je               _exit                ; =
    jmp              _exit_correct        ; !=
    
_exit: 
    PRINT_STRING     'exit process'
    push             dword 0
    mov              eax, 0x1
    int              0x80
    ret              ; return  
 
_exit_correct:
   PRINT_STRING      'finished'
   push              dword 0
   mov               eax, 0x1
   int 0x80
   ret;              ; return