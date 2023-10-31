ASM=nasm
SRC_DIR=src
BIN_DIR=bin
C=i386-elf-gcc
LD=i386-elf-ld

build:
	$(ASM) src/boot/bootsector.asm -f bin -o bin/bootsector.bin
	$(ASM) src/boot/kernel_entry.asm -f elf -o bin/kernel_entry.o
	i386-elf-gcc -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -ffreestanding -c src/kernel/kernel.c -o bin/kernel.o
	$(ASM) src/cpu/interrupt.asm -f elf -o bin/interrupt.o
	$(C) -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -ffreestanding -c src/drivers/keyboard.c -o bin/keyboard.o
	$(C) -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -ffreestanding -c src/drivers/screen.c -o bin/screen.o
	$(C) -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -ffreestanding -c src/cpu/idt.c -o bin/idt.o
	$(C) -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -ffreestanding -c src/cpu/isr.c -o bin/isr.o
	$(C) -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -ffreestanding -c src/cpu/ports.c -o bin/ports.o
	$(C) -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -ffreestanding -c src/cpu/timer.c -o bin/timer.o
	$(C) -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -ffreestanding -c src/libc/mem.c -o bin/mem.o
	$(C) -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -ffreestanding -c src/libc/string.c -o bin/string.o
	$(LD) -o bin/kernel.bin -Ttext 0x1000 bin/kernel_entry.o bin/kernel.o bin/interrupt.o bin/keyboard.o bin/screen.o bin/idt.o bin/isr.o bin/ports.o bin/timer.o bin/mem.o bin/string.o --oformat binary
	cat bin/bootsector.bin bin/kernel.bin > bin/metalfishos.bin

run:
	qemu-system-i386 -fda bin/metalfishos.bin

clean:
	rm bin/*.o
