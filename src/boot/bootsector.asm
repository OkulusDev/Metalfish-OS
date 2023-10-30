; -----------------------------------------------------------------------------
;  Metalfish OS Bootloader source code
;  File: boot/bootsector.asm
;  Title: Загрузочный сектор и вывод строк (bootsector)
;  Last Change Date: 30 October 2023, 11:30 (UTC)
;  Author: Okulus Dev
;  License: GNU GPL v3
; -----------------------------------------------------------------------------
; Description:
;  Загрузочный сектор
; -----------------------------------------------------------------------------

[org 0x7c00]

KERNEL_OFFSET equ 0x1000	; Смещение в памяти, из которого мы загрузим ядро

	mov [BOOT_DRIVE], dl	; BIOS stores our boot drive in DL , so it ’s
							; best to remember this for later. (Remember that
							; the BIOS sets us the boot drive in 'dl' on boot)
	mov bp, 0x9000			; Устанавливаем стек
	mov sp, bp

	mov bx, MSG_REAL_MODE	; Печатаем сообщение
	call puts_chars

	call load_kernel		; Загружаем ядро
	call switch_to_pm		; Переключаемся в Защищенный Режим
	jmp $

%include "src/boot/puts_chars.asm"		; Вывод строки
%include "src/boot/puts_hex.asm"		; ф. печати 16-ричного числа
%include "src/boot/diskload.asm"		; ф. чтения диска
%include "src/boot/puts_chars32.asm"	; Вывод строки в 32 PM
%include "src/boot/switch_to32.asm"	; Переключиться на 32 PM
%include "src/boot/gdt.asm"				; GDT

[bits 16]

load_kernel:
	mov bx, MSG_LOAD_KERNEL
	call puts_chars			; Печатаем сообщение о том, то мы загружаем ядро
							; Устанавливаем параметры для функции disk_load:
	mov bx, KERNEL_OFFSET	; Загрузим данные в место памяти
							; смещению KERNEL_OFFSET
	mov dh, 16				; Загрузим много секторов. *
	mov dl, [BOOT_DRIVE]	; Загрузим данные из BOOT_DRIVE (Возвращаем BOOT_DRIVE)
	call disk_load			; Вызываем функцию disk_load
	ret

[bits 32]					; Сюда мы попадем после переключения в 32PM

BEGIN_PM:
	mov ebx, MSG_PROT_MODE
	call puts_chars_pm		; Печатаем сообщение об успешной загрузке в 32PM
	call KERNEL_OFFSET		; Переходим в адрес, по которому загрузился код ядра
	jmp $


BOOT_DRIVE:			db 0
MSG_REAL_MODE:		db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE:		db "Successfully landed in 32-bit Protected mode", 0
MSG_LOAD_KERNEL:	db "Loading kernel into VIDEO_MEMORY", 0

times 510-($-$$) db 0
dw 0xaa55
