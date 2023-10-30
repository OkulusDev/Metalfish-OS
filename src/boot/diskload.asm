; ------------------------------------------------------------------------------
;  Metalfish OS Bootloader source code
;  File: boot/diskload.asm.asm
;  Title: Функция чтения диска (bootsector)
;  Last Change Date: 30 October 2023, 12:28 (UTC)
;  Author: Okulus Dev
;  License: GNU GPL v3
; ------------------------------------------------------------------------------
;  Metalfish OS Bootloader source code
;  File: bootsector.asm
;  Title: Загрузочный сектор и вывод строк (bootsector)
;  Last Change Date: 29 October 2023, 14:28 (UTC)
;  Author: Okulus Dev
;  License: GNU GPL v3
; Description:
;	Чтобы лучше понять, что здесь происходит, разберитесь с тем, что такое CHS
;	по ссылке https://ru.wikipedia.org/wiki/CHS
; -----------------------------------------------------------------------------

disk_load:
	push dx
	mov ah, 0x02			; Указвыаем БИОСу что нам нужна рутина чтения диска
							; Указываем что нам нужно:
	mov al, dh				; 1. Прочитать кол-во секторов, равное значению в dh
	mov ch, 0x00			; 2. Выбрать нулевой цилиндр
	mov dh, 0x00			; 3. Выбрать нулевую головку
	mov cl, 0x02			; 4. Начинать считывать со второго сектора (т.е.
							; первый свободный сектор сразу после загруочного 
							; сектора, т.к. загрузочный сектор находится по 
							; адресу 0x01)
	int 0x13				; Вызываем прерывание для чтения

							; У БИОСа может не получиться прочитать диск, и
							; чтобы дать нам знать что произошла ошибка, он,
							; во-первых, обновляет специальный флаг CF (carry 
							; flag) специальным значением, которое означает 
							; ошибку, а во-вторых, кладет в регистр AL кол-во 
							; секторов, которые у него получилось прочитать.
	
	jc disk_error			; jc - инструкция для прыжка на указанную метку,
							; которая выполняется только если CF (carry flag)
							; сигнализирует об ошибке

	pop dx					; Восстанавливаем регистр DX из стека
	cmp dh, al				; если AL (кол-во прочитанных секторов) != DH
							; (предполагаемое кол-во секторов),
	jne disk_sectors_error	; то выводим на экран сообщение об ошибке и зависаем
							; (то есть запускаем бесконечный цикл)
	jmp disk_success
	jmp disk_exit			; Заканчиваем выполнение функции

disk_success:
	mov bx, SUCCESS_MSG
	call puts_chars
	jmp disk_exit

disk_error:
	mov bx, DISK_ERR_MSG	; Перемещаем в BX сообщение об ошибке
	call puts_chars		; Выводим его на экран
	mov dh, al
	call puts_hex
	jmp disk_loop			; бесконечный цикл

disk_sectors_error:
	mov bx, SECTORS_ERR_MSG
	call puts_chars

SUCCESS_MSG:
	db "Disk was successfully read ", 0

DISK_ERR_MSG:
	db "Disk read error! ", 0

SECTORS_ERR_MSG:
	db "Incorrect number of sectors read ", 0

disk_loop:
	jmp $

disk_exit:
	ret
