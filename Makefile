SRC_DIR=src
BIN_DIR=bin
ASM=nasm
CC=gcc

BOOTSECTOR_DIR=boot
BOOTSECTOR_SRC=bootsector.asm
BOOTSECTOR_BIN=bootsector.bin
BIN=metalfish.bin

build:
	$(ASM) $(SRC_DIR)/$(BOOTSECTOR_DIR)/$(BOOTSECTOR_SRC) -o $(BIN_DIR)/$(BOOTSECTOR_BIN)

run:
	qemu-system-x86_64 $(BIN_DIR)/$(BOOTSECTOR_BIN)

clean:
	rm bin/*
