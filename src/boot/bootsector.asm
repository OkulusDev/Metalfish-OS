; -----------------------------------------------------------------------------
;  Metalfish OS Bootloader source code
;  File: bootsector.asm
;  Title: Loop bootloader (bootsector)
;  Last Change Date: 29 October 2023, 14:23 (UTC)
;  Author: Okulus Dev
;  License: GNU GPL v3
; -----------------------------------------------------------------------------
; Description:
;  Говорим BIOS, что данное устройство - загрузочное, что здесь установлен
;   загрузочный сектор
;  Для вывода строки мы будем использовать "функцию" из другого файла
; -----------------------------------------------------------------------------
[org 0x7c00]

mov bx, HELLO_MSG				; Перемещаем строку в регистр ax

call puts_chars					; Вызываем функцию puts_chars

mov bx, GOODBYE_MSG
call puts_chars

jmp $							; бесконечный цикл

%include "src/boot/puts_chars.asm"
; ^- директива %include вставляет весь код из
; файла puts_chars.asm в место, откуда она
; была вызвана.

HELLO_MSG:
	db "Metalfish OS bootloader...", 0

GOODBYE_MSG:					; Объявляем метку GOODBYE_MSG
	db " End Booting Metalfish os", 0

times 510-($-$$) db 0			; Заполняем оставшиеся байты нулями
dw 0xaa55						; Вставляем в конец "магическое число" BIOS
