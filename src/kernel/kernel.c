/*------------------------------------------------------------------------------
*  Metalfish OS Kernel source code
*  File:	kernel/kernel.c
*  Title:	Программа на Си, в которую мы загрузимся после boot'а.
*  Last Change Date: 30 October 2023, 12:05 (UTC)
*  Author: Okulus Dev
*  License: GNU GPL v3
* ------------------------------------------------------------------------------
* Description: null
* ----------------------------------------------------------------------------*/


// #include "../common.h"
#include "../drivers/screen.h"
#include "../cpu/isr.h"
#include "kernel.h"
#include "../libc/string.h"


void	kmain() {
	// Запускаемая функция ядра //
	clear_screen();
	isr_install();
    irq_install();

	// clear_screen();

	kprint("Welcome to Metalfish OS 0.9.11\n");
	kprint("Repository: https://github.com/OkulusDev/Metalfish-OS\n\n");

	kprint("MetalShell v0.1.0\n"
	        "Type END to halt the CPU\n"
	        "Type HELP to view commands\n!#> ");
}
	
void user_input(char *input) {
    if (strcmp(input, "END") == 0) {
        kprint("Stopping the CPU. Bye!\n");
        asm volatile("hlt");
    } else if (strcmp(input, "HELP") == 0) {
    	kprint("END - stopping the CPU\n"
    			"INFO - info about OS\n");
    } else if (strcmp(input, "INFO") == 0) {
    	kprint("Metalfish OS 0.9.11 by OkulusDev\n"
    			"Native Build, Release Beta 2\n"
    			"Hello World!\n");
    } else {
    	kprint("[ERROR] INVALID COMMAND: ");
    	kprint(input);
    }
    
    kprint("\n!#> ");
}
	
