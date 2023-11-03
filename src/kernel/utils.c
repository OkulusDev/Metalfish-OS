/*------------------------------------------------------------------------------
*  Metalfish OS Kernel source code
*  File:	kernel/kernel.c
*  Title:	Вспомогательные программы и утилиты для ядра
*  Last Change Date: 30 October 2023, 12:05 (UTC)
*  Author: Okulus Dev
*  License: GNU GPL v3
* ------------------------------------------------------------------------------
* Description: null
* ----------------------------------------------------------------------------*/

#include "utils.h"
#include "../drivers/screen.h"
#include "../libc/mem.h"
#include "../libc/string.h"


void help_command_shell() {
	kprint("END - stopping the CPU\n"
	    	"INFO - info about OS\n"
	    	"PAGE - to request a kmalloc()\n"
	    	"CLEAR - clear the screen\n"
	    	"FETCH - display info about OS\n");
}

void info_command_shell() {
	kprint("Metalfish OS 0.12.20 by OkulusDev\n"
	    	"Native Build, Release Beta 3\n"
	    	"Hello, User!\n");
}

void malloc_command_shell() {
	// kmalloc()
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
}

void fetch_art() {
	kprint_colored(" __ __   __ ___  __      ___ ___  __ |      _   __\n", 14);
	kprint_colored("|  |  | |__  |  |__| |   |__  |  |__ |_    | | |__\n", 14);
	kprint_colored("|  |  | |__  |  |  | |__ |   _|_ __/ | |   |_| __/\n", 14);
	kprint_colored("==================================================\n", 14);
	kprint_colored("OS: METALFISH OS\n", 2);
	kprint_colored("VERSION: 0.12.20\n", 3);
	kprint_colored("SHELL: METALSHELL\n", 4);
	kprint_colored("Copyright (C) Okulus Dev\nRepository: https://github.com/OkulusDev/Metalfish-OS\n", 5);
}
