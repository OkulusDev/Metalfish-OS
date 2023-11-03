ASM=nasm
SRC_DIR=src
BIN_DIR=bin
C=i386-elf-gcc
LD=i386-elf-ld
DISKIMG_NAME=metalfishos_floppy_i386_0.12.18.img

build:
	$(ASM) src/boot/bootsector.asm -f bin -o bin/bootsector.bin
	$(ASM) src/boot/kernel_entry.asm -f elf -o bin/kernel_entry.o
	$(C) -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -ffreestanding -c src/kernel/kernel.c -o bin/kernel.o
	$(ASM) src/cpu/interrupt.asm -f elf -o bin/interrupt.o
	$(C) -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -ffreestanding -c src/kernel/utils.c -o bin/utils.o
	$(C) -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -ffreestanding -c src/drivers/keyboard.c -o bin/keyboard.o
	$(C) -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -ffreestanding -c src/drivers/screen.c -o bin/screen.o
	$(C) -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -ffreestanding -c src/cpu/idt.c -o bin/idt.o
	$(C) -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -ffreestanding -c src/cpu/isr.c -o bin/isr.o
	$(C) -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -ffreestanding -c src/cpu/ports.c -o bin/ports.o
	$(C) -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -ffreestanding -c src/cpu/timer.c -o bin/timer.o
	$(C) -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -ffreestanding -c src/libc/mem.c -o bin/mem.o
	$(C) -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -ffreestanding -c src/libc/string.c -o bin/string.o
	$(LD) -o bin/kernel.bin -Ttext 0x1000 bin/kernel_entry.o bin/kernel.o bin/interrupt.o bin/keyboard.o bin/screen.o bin/idt.o bin/isr.o bin/ports.o bin/timer.o bin/mem.o bin/string.o bin/utils.o --oformat binary
	cat bin/bootsector.bin bin/kernel.bin > bin/metalfishos.bin

fullbuild:
	make build
	make diskimg
	make clean

run_bin:
	qemu-system-i386 -fda bin/metalfishos.bin

diskimg:
	dd if=/dev/zero of=diskimgs/$(DISKIMG_NAME) bs=1024 count=1440
	dd if=$(BIN_DIR)/metalfishos.bin of=diskimgs/$(DISKIMG_NAME) conv=notrunc

run:
	qemu-system-i386 -fda diskimgs/$(DISKIMG_NAME) -boot a

clean:
	rm bin/*.o
