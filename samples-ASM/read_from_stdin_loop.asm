SECTION .bss
    fileBuf: resb 1
SECTION .data
SECTION .text
    global _start
_start:

    nop

  read: mov eax, 3 ; sys_read
        mov ebx, 0 ; standard input
        mov ecx, fileBuf
        mov edx, 1
        int 80h
        cmp eax, 0 ; ensure havn't read eof
        je exit

  write:mov eax, 4 ; sys_write
        mov ebx, 1 ; standard output
        mov ecx, fileBuf
        mov edx, 1
        int 80h
        jmp read

  exit:mov eax, 1 ; wrap it up
       mov ebx, 0
       int 80h