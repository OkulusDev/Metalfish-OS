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
#include "../cpu/ports.h"
#include "../drivers/audio.h"
#include "../cpu/timer.h"


void kmain() {
	// Запускаемая функция ядра //
	clear_screen();
	isr_install();
	irq_install();
	beep();

	// Выводим синию строку с белым текстом о версии
	kprint_colored("METALFISH OS 0.13.24                                                            \n", 15);

	// Приглашение
	kprint("Welcome to Metalfish OS\n");
	kprint("Copyright (C) Okulus Dev\nRepository: https://github.com/OkulusDev/Metalfish-OS\n");

	// Уведомление о старте оболочки командной строки
	kprint("\nMetalShell v0.3.7 "
	        "Type END to halt the CPU\n"
	        "Type HELP to view commands\n\n!#> ");
}

void user_input(char *input) {
	// Пользовательский ввод
    if (strcmp(input, "END") == 0) {
    	// Остановка CPU
        kprint("Stopping the CPU. Bye! (recommended shutdown PC)\n");
        rsod_clear_screen();
        kprint_colored("METALFISH OS 0.13.24                                                            ", 17);
        kprint_colored("RED SCREEN OF DEATH | FATAL ERROR                                               \n", 17);

        kprint_colored("Metalfish OS Kernel Fatal Error\n\n", 16);
        kprint_colored(" >>> Sended END: halting the CPU\n", 16);
        kprint_colored("HLT interrupt assmebly: error code 0x0000000000 (HLTCPU)\n", 16);
        kprint_colored("Recomended: shutdown PC\n\n", 16);
        kprint_colored("[WARNING] This message is normal. Just shutdown or reboot", 16);
        asm volatile("hlt");
    } else if (strcmp(input, "SHUTDOWN") == 0) {
    	outports(0x604, 0x2000);
    } else if (strcmp(input, "HELP") == 0) {
    	/* Вывод строки о помощи
    	strcmp помогает узнать, что ввел пользователь*/
    	help_command_shell();
    } else if (strcmp(input, "CLEAR") == 0) {
    	// Очистка экрана
    	clear_screen();
    	kprint_colored("METALFISH OS 0.13.24                                                           \n", 15);
    } else if (strcmp(input, "INFO") == 0) {
    	// Информация о системе
    	info_command_shell();
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
