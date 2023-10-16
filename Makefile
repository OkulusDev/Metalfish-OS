SRC_DIR=src
BIN_DIR=bin

SRC=metalfish.asm
BIN=metalfish.bin

ASM=fasm

build:
	# Компиляция Metalfish OS
	$(ASM) $(SRC_DIR)/$(SRC) -o $(BIN_DIR)/$(BIN)
