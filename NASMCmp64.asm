%include "io64.inc"

section .data
    git_repo       db      'https://github.com/nerfnet/examplex64/', 0
    empty_field    db      ' ', 0
    
    exit_code      equ     0 ; set value, 0 for ok
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
    PRINT_STRING     'Value incorrect, exit'
    jmp              _terminate
 
_exit_correct:
   PRINT_STRING      'Value correct, exit'
   jmp               _terminate
   
_terminate:          ; hacky termination job, will use ExitProcess in future
  push               exit_code
  push               -1
  push               0
  mov                eax, 0x002a 
  mov                edx, 7FFE0300
  call               dword   ptr   ds:[edx]
  ret                ; return
