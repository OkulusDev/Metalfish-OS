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


#include "../common.h"
#include "../drivers/screen.h"


s32		kmain() {
	// Запускаемая функция ядра //
	u8 i;
	
	clear_screen();

	kprint("Welcome to Metalfish OS 0.8.11\n");
	kprint("\n\nRepository: https://github.com/OkulusDev/Metalfish-OS");

	return 0;
}
