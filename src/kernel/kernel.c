/*------------------------------------------------------------------------------
*  Metalfish OS Kernel source code
*  File:	kernel/kernel.c
*  Title:	Программа на Си, в которую мы загрузимся после boot'а. (ядро)
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

	// Выводим синию строку с белым текстом о версии
	kprint_colored("METALFISH OS 0.11.16                                                            ", 15);

	// Вывод небольшого ascii-арт желтым цветом
	kprint_colored("\n\n __ __   __ ___  __      ___ ___  __ |      _   __\n", 14);
	kprint_colored("|  |  | |__  |  |__| |   |__  |  |__ |_    | | |__\n", 14);
	kprint_colored("|  |  | |__  |  |  | |__ |   _|_ __/ | |   |_| __/\n\n", 14);

	// Приглашение
	kprint("Welcome to Metalfish OS 0.11.16\n");
	kprint("Copyright (C) Okulus Dev\nRepository: https://github.com/OkulusDev/Metalfish-OS\n\n");

	// Уведомление о старте оболочки командной строки
	kprint("MetalShell v0.2.5\n"
	        "Type END to halt the CPU\n"
	        "Type HELP to view commands\n!#> ");
}
	
void user_input(char *input) {
	// Пользовательский ввод
    if (strcmp(input, "END") == 0) {
    	// Остановка CPU
        kprint("Stopping the CPU. Bye! (recommended shutdown PC)\n");
        asm volatile("hlt");
    } else if (strcmp(input, "HELP") == 0) {
    	/* Вывод строки о помощи
    	strcmp помогает узнать, что ввел пользователь*/
    	kprint("END - stopping the CPU\n"
    			"INFO - info about OS\n"
    			"PAGE - to request a kmalloc()\n"
    			"CLEAR - clear the screen\n");
    } else if (strcmp(input, "CLEAR") == 0) {
    	// Очистка экрана
    	clear_screen();
    	kprint_colored("METALFISH OS 0.11.16                                                           ", 15);
    } else if (strcmp(input, "INFO") == 0) {
    	// Информация о система
    	kprint("Metalfish OS 0.11.16 by OkulusDev\n"
    			"Native Build, Release Beta 2\n"
    			"Hello, User!\n");
    }  else if (strcmp(input, "PAGE") == 0) {
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
    } else {
    	// Вывод красным текстом, что комманда неизвестная
    	kprint_colored("[ERROR] INVALID COMMAND: ", 4);
    	kprint(input);
    }

    // Вывод строки шелла
    kprint("\n!#> ");
}
