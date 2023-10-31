/*------------------------------------------------------------------------------
*  Metalfish OS Drivers source code
*  File: drivers/screen.h
*  Title: Загаловочный файл screen.c
*  Last Change Date: 30 October 2023, 12:28 (UTC)
*  Author: Okulus Dev
*  License: GNU GPL v3
* ------------------------------------------------------------------------------
*	Description: null
* ----------------------------------------------------------------------------*/

// #include "../common.h"
// 
// #define VIDEO_ADDRESS 0xb8000	// Адрес начала VGA для печати символов
// #define MAX_ROWS 25				// макс. строк
// #define MAX_COLS 80				// макс. столбцов
// 
// #define WHITE_ON_BLACK 0x0f		// 0x0 == white fg, 0xf == black bg
// #define WHITE_ON_BLUE 0x1f
// 
// // Адреса I/O портов для взаимодействия с экраном.
// #define REG_SCREEN_CTRL 0x3d4	// этот порт для описания данных
// #define REG_SCREEN_DATA 0x3d5	// а этот порт для самих данных
// 
// void	kprint(u8 *str);
// void	putchar(u8 character, u8 attribute_byte);
// void	clear_screen();
// void	write(u8 character, u8 attribute_byte, u16 offset);
// void	scroll_line();
// u16		get_cursor();
// void	set_cursor(u16 pos);
// 

#ifndef SCREEN_H
#define SCREEN_H

#include "../cpu/types.h"

#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80
#define WHITE_ON_BLACK 0x0f
#define RED_ON_WHITE 0xf4
#define WHITE_ON_BLUE 0x1f

/* Screen i/o ports */
#define REG_SCREEN_CTRL 0x3d4
#define REG_SCREEN_DATA 0x3d5

/* Public kernel API */
void clear_screen();
void kprint_at(char *message, int col, int row);
void kprint(char *message);
void kprint_backspace();

#endif

