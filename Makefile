
build:
	i686-elf-as src/boot.s -o boot.o
	i686-elf-gcc -c src/kernel.c -o bin/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
	i686-elf-gcc -T src/linker.ld -o bin/my_kernel.bin -ffreestanding -O2 -nostdlib bin/boot.o bin/kernel.o -lgcc
