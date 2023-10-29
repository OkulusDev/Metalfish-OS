SRC_DIR=src
BIN_DIR=bin
ASM=nasm
CC=gcc

build:
	$(ASM) $(SRC_DIR)/bootsector.asm -o $(BIN_DIR)/bootsector.bin

run:
	qemu-system-x86_64 bin/bootsector.bin	
