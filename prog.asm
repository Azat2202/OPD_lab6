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
X:			WORD	0xF0F0
X_MAX:		WORD	0x7FFF
X_MIN:		WORD	0x8003	;Нижняя граница ОДЗ (включительно)

START:		DI
			CLA
			LD		#0xA	;Загрузка в AC MR(1000|0010 = 1010)
			OUT		0x5		;Разрешение прерываний для ВУ-2
			LD		#0xB	;Загрузка в AC MR(1000|0011 = 1011)
			OUT		0x7		;Разрешение прерываний для ВУ-3
			EI

MAIN:		DI				;Запрет прерываний для атомарности операции
			LD		$X		;Загружаем Х
			SUB		#0x3	;Вычитаем 3
			CMP		X_MIN	;Если в границах ОДЗ пропускаем запуск максимального значения
			BGE		ODZ_OK	
			LD		X_MAX	
ODZ_OK:		ST		$X		
			EI
			OUT		0x1
			BR		MAIN
			
			
			
			
			
			
			
			
			
			
			
			