/*------------------------------------------------------------------------------
*  Metalfish OS Drivers source code
*  File: drivers/lowlevel_io.h
*  Title: Заголовочный файл для drivers/lowlevel_io.c
*  Last Change Date: 30 October 2023, 12:28 (UTC)
*  Author: Okulus Dev
*  License: GNU GPL v3
*/

unsigned char   port_byte_in(unsigned short port);
void    port_byte_out(unsigned short port, unsigned char data);
unsigned char   port_word_in(unsigned short port);
void port_word_out(unsigned short port, unsigned short data);

