BITS 32

section .data
    msg db "Hola", 10
    msglen equ $-msg

section .bss
    src_file    resd 1      ; Source file descriptor
    dest_file   resd 1      ; Destination file descriptor

section .text
    global _start

_start:
    pop ebx             ; argc
    pop ebx             ; argv[0] executable name

    pop ebx             ; argv[1] src file name
    ;; Open src file
    mov ecx,1           ; Write mode
    mov eax,5           ; sys_open()
    int 0x80            ; Interruption 80. kernel call
    mov [src_file],eax

    pop ebx             ; argv[2] dest file name
    ;; Open dest file
    mov ecx,1           ; Write mode
    mov eax,5           ; sys_open()
    int 0x80            ; Interruption 80. kernel call
    mov [dest_file],eax

    ;; Writes in src file
    mov edx,msglen      ; Long
    mov ecx,msg         ; text
    mov ebx,[src_file]  ; File descriptor of dest file
    mov eax,4           ; sys_write()
    int 0x80

    ;; Closes src file
    mov ebx,[src_file]  ; File descriptor of src file
    mov eax,6           ; sys_close()
    int 0x80            ; Kernel call

    ;; Closes dest file
    mov ebx,[dest_file] ; File descriptor of src file
    mov eax,6           ; sys_close()
    int 0x80            ; Kernel call

    ;; Exits the program
    mov ebx,0           ; OS exit code
    mov eax,1           ; sys_exit
    int 0x80            ; Kernel call