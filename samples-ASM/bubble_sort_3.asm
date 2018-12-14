; (c) https://forum.nasm.us/index.php?topic=1594.0

sys_creat equ 8
sys_write equ 4
sys_exit  equ 1
sys_close equ 6
stdout    equ 1
stderr    equ 3

section .data
  msg db "%d"
  four dd 4
  msga db "%d ",0

section .bss
  arr resd 8

section .text
  global main
  extern printf
  extern scanf

main:
  xor ecx,ecx ;; zerar o registrador

lp:
  mov ebx,arr     ;; from this line to jnz lp is using for taking 8 inputs
  mov eax,ecx
  mul dword[four]
  add ebx,eax
  pusha

  push ebx
  push msg
  call scanf
  add esp,8
  popa

  inc ecx
  cmp ecx,8
  jnz lp

  mov ecx,0   ;; sorting replication of the above c program is starting
  mov ebx,7   ;; outerloop will execute from 0 to 7

outerLoop:
  mov eax,0   ;; it sets ptr=0

.innerLoop:
  mov edx,8
  sub edx,ecx
  cmp eax,edx  ;; its using for cheking ptr<=n-k

  push ebx
  push ecx
  push edx
  ; add esp,12

  jle .task
  pop edx
  pop ecx
  pop ebx
  inc ecx

  cmp ecx, ebx ;; its using for cheking whether k is in between 0 to 7
  jl outerLoop

  xor ecx,ecx
  jmp lp1

.task:
  mov ebx,dword[arr+eax*4]   ;; its using to get data[ptr]
  mov ecx,eax
  push eax
  ; add esp,4

  add ecx,1
  mov edx,dword[arr+ecx*4]   ;; its using to get data[ptr+1]

  cmp ebx,edx
  jl .activity
  xchg ebx,edx
  mov dword[arr+eax*4],ebx
  mov dword[arr+ecx*4],edx

.activity:
  pop eax
  pop edx
  pop ecx
  pop ebx

  inc eax
  jmp .innerLoop

lp1:                 ;; its using for print the output
  mov ebx,arr
  mov eax,ecx

  mul dword[four]
  add ebx,eax
  pusha

  push dword[ebx]
  push msga
  call printf

  add esp,8
  popa
  inc ecx
  cmp ecx,8
  jne lp1
