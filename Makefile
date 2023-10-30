SRC_DIR=src
BIN_DIR=bin
ASM=nasm
ASM_FLAGS=-f bin
C=i386-elf-gcc
CC_FLAGS=-g
LD=i386-elf-ld

C_FILES = $(shell find src/drivers/*.c src/*.c)
temp = $(C_FILES)
O_FILES=$(shell find bin/*.o | sed 's/bin\/kernel_entry.o//' | sed 's/bin\/kernel.o//')

SOURCES=src/common.c src/drivers/lowlevel_io.c src/drivers/screen.c
OBJECTS=$(SOURCES:.c=o)

BOOTSECTOR_DIR=boot
BIN=metalfish.bin

KERNEL_DIR=kernel

run: metalfishos.bin
	qemu-system-i386 -fda $(BIN_DIR)/metalfishos.bin

metalfishos.bin: bootsector.bin kernel.bin
	cat $(BIN_DIR)/bootsector.bin $(BIN_DIR)/kernel.bin > $(BIN_DIR)/metalfishos.bin

bootsector.bin:
	$(ASM) $(ASM_FLAGS) $(SRC_DIR)/$(BOOTSECTOR_DIR)/bootsector.asm -o $(BIN_DIR)/bootsector.bin

kernel.bin: kernel_entry.o kernel.o
	$(LD) -o $(BIN_DIR)/kernel.bin -Ttext 0x1000 bin/kernel_entry.o bin/kernel.o $(O_FILES) --oformat binary

kernel_entry.o:
	$(ASM) $(SRC_DIR)/$(BOOTSECTOR_DIR)/kernel_entry.asm -f elf -o $(BIN_DIR)/kernel_entry.o

kernel.o:
	$(C) $(CC_FLAGS) -ffreestanding -c src/kernel/kernel.c $(C_FILES)
	mv *.o bin/

kernel.elf: kernel_entry.o kernel.o
	$(LD) -o $(BIN_DIR)/kernel.bin -Ttext 0x1000 $(BIN_DIR)/kernel_entry.o $(BIN_DIR)/kernel.o $(O_FILES) -o $(BIN_DIR)/kernel.elf
	
clean:
	rm bin/*.o
	rm bin/*.c
