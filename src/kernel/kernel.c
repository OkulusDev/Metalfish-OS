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
#include "../cpu/isr.h"
#include "../drivers/screen.h"
#include "kernel.h"
#include "../libc/string.h"
#include "../libc/mem.h"


void kmain() {
	// Запускаемая функция ядра //
	clear_screen();
	isr_install();
    irq_install();

	kprint_colored("METALFISH OS 0.11.14                                                            ", 15);

	kprint_colored("\n\n __ __   __ ___  __      ___ ___  __ |      _   __\n", 14);
	kprint_colored("|  |  | |__  |  |__| |   |__  |  |__ |_    | | |__\n", 14);
	kprint_colored("|  |  | |__  |  |  | |__ |   _|_ __/ | |   |_| __/\n\n", 14);
	
	kprint("Welcome to Metalfish OS 0.11.14\n");
	kprint("Repository: https://github.com/OkulusDev/Metalfish-OS\n\n");

	kprint("MetalShell v0.2.4\n"
	        "Type END to halt the CPU\n"
	        "Type HELP to view commands\n!#> ");
}
	
void user_input(char *input) {
    if (strcmp(input, "END") == 0) {
        kprint("Stopping the CPU. Bye! (Shutdown PC)\n");
        asm volatile("hlt");
    } else if (strcmp(input, "HELP") == 0) {
    	kprint("END - stopping the CPU\n"
    			"INFO - info about OS\n"
    			"PAGE - to request a kmalloc()\n"
    			"CLEAR - clear the screen\n");
    } else if (strcmp(input, "CLEAR") == 0) {
    	clear_screen();
    	kprint_colored("METALFISH OS 0.11.14                                                            ", 15);
    } else if (strcmp(input, "INFO") == 0) {
    	kprint("Metalfish OS 0.11.14 by OkulusDev\n"
    			"Native Build, Release Beta 2\n"
    			"Hello, User!\n");
    }  else if (strcmp(input, "PAGE") == 0) {
		u32 phys_addr;
        u32 page = kmalloc(1000, 1, &phys_addr);
        char page_str[16] = "";
        hex_to_ascii(page, page_str);
        char phys_str[16] = "";
        hex_to_ascii(phys_addr, phys_str);
        kprint("Page: ");
        kprint(page_str);
        kprint(", physical address: ");
        kprint(phys_str);
        kprint("\n");
    } else {
    	kprint("[ERROR] INVALID COMMAND: ");
    	kprint(input);
    }
    
    kprint("\n!#> ");
}
