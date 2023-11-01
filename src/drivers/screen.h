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

#include "../cpu/type.h"

#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80
#define WHITE_ON_BLACK 0x0f
#define WHITE_ON_BLUE 0x1f
#define WHITE_ON_DGREY 0x8

#define BLUE_ON_BLACK 0x01
#define GREEN_ON_BLACK 0x02
#define CYAN_ON_BLACK 0x03
#define RED_ON_BLACK 0x04
#define MAGENTA_ON_BLACK 0x05
#define BROWN_ON_BLACK 0x06
#define LGREY_ON_BLACK 0x07
#define DGREY_ON_BLACK 0x08
#define LBLUE_ON_BLACK 0x09
#define LGREEN_ON_BLACK 0x0A
#define LCYAN_ON_BLACK 0x0B
#define LRED_ON_BLACK 0x0C
#define LMAGENTA_ON_BLACK 0x0D
#define YELLOW_ON_BLACK 0x0E

#define RED_ON_WHITE 0xf4

/* Screen i/o ports */
#define REG_SCREEN_CTRL 0x3d4
#define REG_SCREEN_DATA 0x3d5

/* Public kernel API */
void clear_screen();
void kprint_at(char *message, int col, int row, int color);
void kprint(char *message);
void kprint_colored(char *message, int color);
void kprint_backspace();

#endif
