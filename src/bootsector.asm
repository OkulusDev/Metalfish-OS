; -----------------------------------------------------------------------------
;  Metalfish OS source code
;  File: bootsector.asm
;  Title: Loop bootloader (bootsector)
;  Last Change Date: 29 October 2023, 17:06 (UTC)
;  Author: Okulus Dev
;  License: GNU GPL v3
; -----------------------------------------------------------------------------
; Description:
;  Говорим BIOS, что данное устройство - загрузочное, что здесь установлен
;  загрузочный сектор
; -----------------------------------------------------------------------------

loop:									; создаем метку вечного цикла
	jmp loop							; переходим к началу метки

times 510-($-$$) db 0

dw 0xaa55
