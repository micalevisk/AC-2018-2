Escrever e compilar um código em assembler i386 que na hora da execução aceite dois argumentos de entrada, primeiro a frase que será escrita, por exemplo "Arquitetura 20181", e segundo o nome de um arquivo de saída 'saida.txt'. O programa deve gerar o arquivo 'saida.txt' com a frase "Arquitetura 20181" dentro (sem aspas).

Instruções para compilar e executar num computador Linux x86_64.

Instalar:
```bash
$ sudo apt-get install nasm  libc6-dev-i386  ia32-libs
```

Compilar e executar com os comandos:

```bash
$ nasm -f elf codigo_do_aluno_x.asm
$ ld -m elf_i386 -o codigo_do_aluno_x codigo_do_aluno_x.o
$ ./codigo_do_aluno_x "Arquitetura 2018" saida.txt
```