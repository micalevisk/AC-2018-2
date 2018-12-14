;; nasm -f elf codigo_do_aluno_micael.asm
;; ld -m elf_i386 -o codigo_do_aluno_micael codigo_do_aluno_micael.o
;; ./codigo_do_aluno_micael "Arquitetura 2018" saida.txt
;; head -3 codigo_do_aluno_micael.asm | cut -d';' -f3- | sh
BITS 32

NUM_ARGS  equ 3
sys_creat equ 8
sys_write equ 4
sys_exit  equ 1
sys_close equ 6
stdout    equ 1
stderr    equ 3

section .data
     msgdone db 'Escrito no arquivo',0xA
  lenmsgdone equ $-msgdone

     msgusage db 'command line args: "<conteudo>" <arquivo_a_ser_criado>',0xA
  lenmsgusage equ $-msgusage

section .text
  global _start

_start:

  cmp dword [esp], NUM_ARGS  ; se `argc` não for igual a `NUM_ARGS` (usando o stack pointer)
  jne NoArgs                 ; encerrar o programa

  mov eax, sys_creat            ; definir operação para criar arquivo
  mov ebx, dword [esp + 4 * 3]  ; definir o arquivo de saída (argv[2])
  mov ecx, 0666o                ; definir permissão -rw-rw-rw- para o arquivo (número em octal)
  int 80H                       ; interrupção 80. kernel call

  mov ebx, eax                  ; definir o descritor do arquivo
  mov ecx, dword [esp + 4 * 2]  ; definir o ponteiro para o buffer de saída (argv[1])

  ;; guardar o comprimento da string apontada por `ecx` em `edx`
  xor edx, edx                  ; garantir que `edx` é zero inicialmente
  loop_begin_getlen:
    cmp byte [ecx + edx], 0
    jz loop_end_getlen
    inc edx
    jmp loop_begin_getlen

  loop_end_getlen:
  ;; escrever no arquivo
  mov eax, sys_write  ; definir a operação para escrever no arquivo
  int 80H             ; interrupção 80. kernel call

  ;; fechar o arquivo
  mov eax, sys_close   ; (o EBX deve ter o descritor do arquivo a ser fechado)
  int 80H              ; interrupção 80. kernel call

  push lenmsgdone
  push msgdone
  call Print

  ;; encerrar o programa
_end:
  mov ebx, 0         ; OS exit code
  mov eax, sys_exit
  int 80H            ; interrupção 80. kernel call


;; in: <msg> <len>
Print:
  push    ebx
  mov     ebp, esp
  mov     ecx, [ebp + 4 * 2] ; primeiro argumento
  mov     edx, [ebp + 4 * 3] ; segundo argumento

  mov     eax, sys_write
  mov     ebx, stdout
  int     80H

  leave   ; mov esp,ebp / pop ebp
  ret

NoArgs:
  push    lenmsgusage
  push    msgusage
  call    Print
  jmp     _end



;; RESOURCES:
;; https://www.nasm.us/doc/nasmdoc9.html
;; https://stackoverflow.com/questions/4526424/writing-to-a-file-in-nasm-using-system-calls
;; https://www.tutorialspoint.com/assembly_programming/assembly_system_calls.htm
;; https://www.tutorialspoint.com/assembly_programming/assembly_file_management.htm
;; http://issc.uj.ac.za/assembler/NASM.pdf