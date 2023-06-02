; Программа реализующая CAS алгоритм. Незаваершена. Работоспособность не гарантирована.

			ORG		0x0
v0:			WORD	$default, 0x180
v1:			WORD	$default, 0x180
v2:			WORD	$default, 0x180
v3:			WORD	$default, 0x180
v4:			WORD	$default, 0x180
v5:			WORD	$default, 0x180
v6:			WORD	$default, 0x180
v7:			WORD	$default, 0x180

default:	IRET	

			ORG		0x039
X:			WORD	0xFFFF
X_MAX:		WORD	0x7FFF
X_MIN:		WORD	0x8001

START:		DI
			CLA
			LD		#0xA	;Загрузка в AC MR(1000|0010 = 1010)
			OUT		0x5		;Разрешение прерываний для ВУ-2
			LD		#0xB	;Загрузка в AC MR(1000|0011 = 1011)
			OUT		0x7		;Разрешение прерываний для ВУ-3
			EI

MAIN:		LD		$X		;Загрузка изначального значения X
			OUT		0x2
			PUSH			;Сохранение изначального значения X на стеке
			SUB		#0x3	;Вычисление нового значения X
			CALL	CHECK	;Проверка нового значения по ОДЗ
			PUSH			;Сохранение нового значения X на стеке
			CALL	CAS		;Обращение к подпрограмме Compare-And-Swap
							;С аргументами: старое значение Х, новое значение Х
			BR		MAIN	


CHECK:		CMP		X_MIN	;Проверка по ОДЗ
			BLT		CHECK_LESS
			RET
CHECK_LESS:	LD		$X_MAX
			RET

CAS:		LD		$X		;Если загружаем текущее значение Х
			CMP		&2		;Сравниваем текущее значение Х со значением до операций
			BNE		EXIT	;Если значения не совпадают выходим
			LD		&1		;Если значения совпадают сохраняем новое значение
			ST		$X
EXIT:		POP				;Очищаем стек, но сохраняем адрес возврата
			SWAP
			POP
			SWAP
			POP
			SWAP
			RET
			
			
			
			
			
			
			
			
			
			
			