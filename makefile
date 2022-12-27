fibonacci: fibonacci.o
	ld -o fibonacci fibonacci.o
fibonacci.o: fibonacci.asm
	nasm -f elf64 -g -F dwarf -o fibonacci.o fibonacci.asm

fibonacciwithio: fibonacciwithio.o
	ld -o fibonacciwithio fibonacciwithio.o
fibonacciwithio.o: fibonacciwithio.asm
	nasm -f elf64 -g -F dwarf -o fibonacciwithio.o fibonacciwithio.asm
