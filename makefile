FILENAME := $(basename $(FILE))
FORMAT   := elf

$(FILENAME):
	nasm -f $(FORMAT) $@.asm
	# ld -m elf_i386 -o $@.exe $@.o
	gcc -m32 -o $@.exe $@.o
	$(MAKE) run

clean:
	$(RM) *.o *.exe

run:
	./$(FILENAME).exe
