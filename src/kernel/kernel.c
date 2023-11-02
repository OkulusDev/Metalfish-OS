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
#include "utils.h"
#include "../libc/string.h"


void kmain() {
	// Запускаемая функция ядра //
	clear_screen();
	isr_install();
    irq_install();

	// Выводим синию строку с белым текстом о версии
	kprint_colored("METALFISH OS 0.12.17                                                            \n", 15);

	// Приглашение
	kprint("Welcome to Metalfish OS\n");
	kprint("Copyright (C) Okulus Dev\nRepository: https://github.com/OkulusDev/Metalfish-OS\n\n");

	// Вывод небольшого ascii-арт желтым цветом
	fetch_art();

	// Уведомление о старте оболочки командной строки
	kprint("\nMetalShell v0.3.5\n"
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
    	help_command_shell();
    } else if (strcmp(input, "CLEAR") == 0) {
    	// Очистка экрана
    	clear_screen();
    	kprint_colored("METALFISH OS 0.12.17                                                           \n", 15);
    } else if (strcmp(input, "INFO") == 0) {
    	// Информация о система
    	info_command_shell();
    } else if (strcmp(input, "FETCH") == 0) {
    	fetch_art();
    }  else if (strcmp(input, "PAGE") == 0) {
    	malloc_command_shell();
    } else {
    	// Вывод красным текстом, что комманда неизвестная
    	kprint_colored("[ERROR] INVALID COMMAND: ", 4);
    	kprint(input);
    }

    // Вывод строки шелла
    kprint("\n!#> ");
}
