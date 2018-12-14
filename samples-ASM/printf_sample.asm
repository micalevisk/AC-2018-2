; --------------------------------------------------------------------------
; This is a Win32 console program that writes "Hello, World" on one line and
; then exits.  It needs to be linked with a C library.
; --------------------------------------------------------------------------

section .text
  global  main
  extern  printf

main:
  push    message ; parâmetro
  call    printf
  add     esp, 4
  mov     ebx, 0  ; OS exit code
  mov     eax, 1  ; sys_exit
  int     80H     ; call

message:
  db  'Hello, World', 10, 0
  ;                   |   ^ null char
  ;                   ^ Line Feed char