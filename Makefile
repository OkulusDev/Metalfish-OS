SRC_DIR=src
BIN_DIR=bin
ASM=nasm
ASM_FLAGS=-f bin
C=i386-elf-gcc
CC_FLAGS=-g
LD=i386-elf-ld

BOOTSECTOR_DIR=boot
BOOTSECTOR_SRC=bootsector.asm
BOOTSECTOR_BIN=bootsector.bin
BIN=metalfish.bin

KERNEL_DIR=kernel
KERNEL_SRC=kernel.c
KERNEL_BIN=kernel.bin

install_toolchain:
	wget http://newos.org/toolchains/i386-elf-4.9.1-Linux-x86_64.tar.xz
	sudo mkdir /usr/local/i386elfgcc
	sudo tar -xf i386-elf-4.9.1-Linux-x86_64.tar.xz -C /usr/local/i386elfgcc --strip-components=1
	export PATH=$PATH:/usr/local/i386elfgcc/bin

build:
	$(ASM) $(ASM_FLAGS) $(SRC_DIR)/$(BOOTSECTOR_DIR)/$(BOOTSECTOR_SRC) -o $(BIN_DIR)/$(BOOTSECTOR_BIN)
	$(ASM) $(SRC_DIR)/$(BOOTSECTOR_DIR)/kernel_entry.asm -f elf -o $(BIN_DIR)/kernel_entry.o
	$(C) ${CFLAGS} -ffreestanding -c $(SRC_DIR)/$(KERNEL_DIR)/$(KERNEL_SRC) -o $(BIN_DIR)/kernel.o
	$(LD) -o $(BIN_DIR)/kernel.bin -Ttext 0x1000 $(BIN_DIR)/kernel_entry.o $(BIN_DIR)/kernel.o --oformat binary
	$(LD) -o $(BIN_DIR)/kernel.bin -Ttext 0x1000 $(BIN_DIR)/kernel_entry.o $(BIN_DIR)/kernel.o -o $(BIN_DIR)/kernel.elf
	cat $(BIN_DIR)/$(BOOTSECTOR_BIN) $(BIN_DIR)/$(KERNEL_BIN) > $(BIN_DIR)/metalfishos.bin

run:
	qemu-system-i386 -fda $(BIN_DIR)/metalfishos.bin

create_bin:
	cat $(BIN_DIR)/$(BOOTSECTOR_BIN) $(KERNEL_DIR)/$(KERNEL_BIN) > $(BIN_DIR)/metalfishos.bin

clean:
	rm bin/*
