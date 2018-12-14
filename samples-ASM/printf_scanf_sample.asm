; #include <stdio.h>
; int main(int argc, char *argv[])
; {
;     int integer1, integer2;
;     printf("Enter the first number: ");
;     scanf("%d", &integer1);
;     printf("Enter the second number: ");
;     scanf("%d", &integer2);
;     printf("%d\n", integer1+integer2);
;     return 0;
; }
;
; int add(int a, int b) { return a+b; }

SECTION .data
  message1: db "Enter the first number: ", 0
  message2: db "Enter the second number: ", 0
  formatin: db "%d", 0
  formatout: db "%d", 10, 0 ; newline, nul terminator
  integer1: times 4 db 0    ; 32-bits integer = 4 bytes
  integer2: times 4 db 0

SECTION .text
  global main
  extern scanf
  extern printf

main:
  push ebx ; save registers
  push ecx
  push message1
  call printf

  add esp, 4 ; remove first parameter
  push integer1 ; address of integer1 (second parameter)
  push formatin ; arguments are right to left (first parameter)
  call scanf

  add esp, 8 ; remove second parameter
  push message2
  call printf

  add esp, 4 ; remove parameters
  push integer2 ; address of integer2
  push formatin ; arguments are right to left
  call scanf

  add esp, 8 ; remove second parameter

  push dword [integer1]
  push dword [integer2]
  call _add
  add esp, 8

  ; mov ebx, dword [integer1]
  ; mov ecx, dword [integer2]
  ; add ebx, ecx ; add the values          ; the addition

  push ebx
  push formatout
  call printf                            ; call printf to display the sum

  add esp, 8                             ; remove parameters
  pop ecx
  pop ebx ; restore registers in reverse order
  mov eax, 0 ; no error
  ret ; return address is in [esp] (stack pointer)

_add:
  ; [esp] is the return address
  ; [esp+4] the first parameter, etc
  mov ebx, [esp+4*1]
  add ebx, [esp+4*2]
  ret