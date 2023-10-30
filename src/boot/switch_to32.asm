; ------------------------------------------------------------------------------
;  Metalfish OS Bootloader source code
;  File: boot/switch_to32.asm
;  Title: Переключаемся в PM (Protected mode, защищенный режим)
;  Last Change Date: 30 October 2023, 11:30 (UTC)
;  Author: Okulus Dev
;  License: GNU GPL v3
; ------------------------------------------------------------------------------
; Description:
;	Чтобы сделать свитч, нам нужно:
;		1. Отключить прерывания (процессор просто будет их игнорировать), т.к.
; 		в PM, прерывания обрабатываются совершенно по-другому в отличие от
;		Real Mode. Даже если процессор и смог бы распределить сигналы прерываний
;		по конкретным BIOS обработчикам прерываний, БИОС обработчики будут
;		обрабатывать 16-битный код, что повлекло бы за собой ошибки.
;		2. Загрузить GDT дескриптор
;		3. Изменяем первый бит регистра управления cr0 на "1"
;		https://en.wikipedia.org/wiki/Control_register#CR0
;		4. Т.к. процессор использует специальную технику, которая называется
;		называется pipelining (гугли: вычислительный конвейер, полезная статья
;		на хабре: https://habr.com/ru/post/182002/), и поэтому сразу после того,
;		как перевести процессор в PM (что мы и сделали в предыдущем пункте), 
;		нам нужно заставить процессор завершить всю работу в конвейере, чтобы
;		быть уверенным, что все будущие инструкции будут выполнены корректно.
;		Конвейер загружает в себя некоторые количество последующих после текущей
;		инструкций, но конвейеру не очень нравятся инструкции типа call и jmp,
;		т.к. процессор не знает полностью какие инструкции будут следовать за
;		ними, в особенности если мы вызовем jmp или call "прыгая" в другой
;		сегмент. Поэтому нам нужно сделать "дальний прыжок", чтобы стереть 
;		обрабатываемые в конвейере инструкции.
;		Сам прыжок: 	jmp <сегмент>:<адрес смещения>
; ------------------------------------------------------------------------------


[bits 16]

switch_to_pm:
	cli						; Отключаем прерывания (cli = clear interrupts)
	
	lgdt [gdt_descriptor]	; Загружаем GDT дескриптор (lgdt = load GDT)

	mov eax, cr0			; Чтобы перейти в PM, нужно чтобы первый бит
	or eax, 0x1				; регистра управления cr0 был 1
	mov cr0, eax

	jmp CODE_SEG:init_pm	; Делаем "дальний прыжок" в наш новый 32-битный
							; сегмент кода. Это так же заставляет процессор
							; завершить обрабатываемые в конвейере инструкции. 

[bits 32]

init_pm:					; в PM, наши старые сегменты бесполезны, поэтому
	mov ax, DATA_SEG		; мы делаем так, чтобы регистры всех сегментов
	mov ds, ax				; указывали на сегмент данных, который мы определили
	mov ss, ax				; в GDT (см. ./gdt.asm)
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000		; Обновляем позицию стека, чтобы он был на самом
	mov esp, ebp			; верху свободного места

	call BEGIN_PM			; Вызываем функцию из ./main.asm
