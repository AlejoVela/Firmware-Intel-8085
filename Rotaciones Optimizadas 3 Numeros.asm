.ORG 0000H
  JMP INI

		D0 DB 06H, 09H, 09H, 09H, 09H, 06H
.ORG 0103H
		D1 DB 04H, 0CH, 04H, 04H, 04H, 0EH
.ORG 0203H
		D2 DB 06H, 09H, 02H, 04H, 08H, 0FH
.ORG 0303H
		D3 DB 0FH, 01H, 07H, 01H, 01H, 0FH
.ORG 0403H
		D4 DB 09H, 09H, 0FH, 01H, 01H, 01H
.ORG 0503H
		D5 DB 0FH, 08H, 0FH, 01H, 01H, 0FH
.ORG 0603H
		D6 DB 0FH, 08H, 0FH, 09H, 09H, 0FH
.ORG 0703H
		D7 DB 0FH, 09H, 01H, 01H, 01H, 01H
.ORG 0803H
		D8 DB 06H, 09H, 06H, 06H, 09H, 06H
.ORG 0903H
		D9 DB 0FH, 09H, 0FH, 01H, 01H, 01H
.ORG 0A00H



INI: MVI H, 10H                       ;SE PUEDE OBVIAR ESTA PARTE CUANDO SE INTEGRE AL PROYECTO
  MVI L, 50H                          ;DIRECCIONAMOS AL NEABLE BAJO
  MVI M, 37H                          ;GUARDAMOS EL DATO EN EL NEABLO BAJO
  INR L                               ;AUMENTAMOS PARA LLEGAR AL NEABLE ALTO
  MVI M, 09H                          ;GUARDAMOS EL DATO EN EL NEABLE ALTO

 ;ROTAMOS EL NEABLE ALTO
  MOV A,M                             ;Lo pasamos al acumulador
	ANI 0FH                             ;le Hacemos una mascara
 CALL VISUALIZACION                   ;Llamamos a la funcion para rotar

 ;ROTAMOS EL NEABLE BAJO
 MVI H, 10H
 MVI L, 50H
 MOV A,M			 										    ;TRAEMOS EL DATO DEL NEABLE ALTO AL ACUMULADOR(YA QUE PRIMERO DEBEMOS ROTAR EL NEABLE ALTO)
	ANI F0H													    ;hacemos una mascara para los bits de menor peso
 RRC 							                    ;ROTAMOS 4 VECES A LA DERECHA SIN ACARREO
 RRC                                  ;ROTAMOS HACIA LA DERECHA PARA PONER EL DATO EN
 RRC 																  ;ENABLE BAJO
	RRC
 CALL VISUALIZACION                   ;Llamamos a la funcion para rotar
  MVI H, 10H
	MVI L, 50H                          ;RECUPERAMOS EL DATO PARA ROTAR Y MOSTRAR SUS PRIMEROS 4 BITS
  MOV A,M                             ;Lo pasamos al acumulador
	ANI 0FH                             ;le Hacemos una mascara
 CALL VISUALIZACION                   ;Llamamos a la funcion para rotar

HLT




VISUALIZACION: LXI H,D0        ;VOLVEMOS A LA POSICION DONDE GUADAMOS LOS DATOS DEL CERO MATRICIAL
 ADD H	                              ;SUMAMOS EL REGISTRO H AL A PARA UBICAR LA MATRIZ DE DATOS A COPIAR
 MOV H,A	                           ;Movemos el resultado de la suma a H, para tener la direccion con el numero indicado
	LXI D,8000H                        ;Direccionamos D para guardar una copia de lo direccionado por H
	MVI B,06H                          ;Ponemos un 6 para iterar todos los datos en &(HL)

;EN ESTA PARTE PROCEDEMOS A CREAR UNA COPIA DE TODOS LOS DATOS DE HL EN DE

COPIA: MOV A,M                      ;Ponemos en el acumulador el dato direccionado por &(HL)
 STAX D 																        ;Hacemos una copia de lo que hay en A en la memoria &(DE), que esta en 8000H
 INX H 																		       ;AUMENTAMOS H
 INX D	                              ;AUMENTAMOS D
 DCR B                              ;DECREMENTAMOS B
	JNZ COPIA															       ;Seguimos hasta que B sea cero (hasta que hayamos recorrido las filas)

;UNA VEZ GUARDADA LA LISTA, RECORREMOS FILAS Y COLUMNAS PARA ROTAR LOS DATOS

	MVI B,04H                          ;Movemos 04H a B para iterarlas columnas
COLUMNA: MVI C,06H                  ;MOVEMOS EL DATO 06 A C PARA UNA ITERACION DE COLUMNAS
LXI D, 8000H	                       ;VOLVEMOS A LA POSICION DONDE HICIMOS LA COPIA
	LXI H,9000H                       ;Iniciamos en la posicion 9000H, aqui guardaremos los numeros rotados
C2: LDAX D	                        ;Cargamos a A con el contenido direccionado por &(DE)
 RAL                               ;ROTAMOS UNA VEZ A A LA IZQUIERDA CON ACARREO
 STAX D                            ;PASAMOS EL RESULTADO DE A A LA MEMORIA DE
 MOV M,A                           ;Guardamos tambien el resultado en la memoria &(HL)
 INX D                             ;INCREMENTAMOS D
 INX H                             ;INCREMENTAMOS H
 DCR C                             ;DECREMENTAMOS LAS FILAS C
	JNZ C2                            ;Comprobamos si ya hemos recorrido las filas osea C=0
 CALL IMP                          ;Una vez rotados los datos, los mandamos a imprimir

 DCR B                             ;Cuando ya hemos imprido los datos, decrementamos B, para seguir
																												;iterando las columnas
 JNZ COLUMNA                        ;Comprobamos si ya hemos recorrido las Columnas osea B = 0
RET





IMP: LXI H,9000H     ;Iniciamos en la posicion 0900H, ya que aqui tenemos los numeros rotados

		MOV A,M           ;se mueve el contenido direccionado por &(HL) a A
 		OUT 01H           ;Se muestra en el primer puerto
  	INX H             ;Se incrementa H
  	MOV A,M           ;Se mueve el contenido direccionado a A
		OUT 02H           ;Se muestra por puerto
		INX H             ;y se repite el proceso...
		MOV A,M
		OUT 03H
		INX H
		MOV A,M
		OUT 04H
		INX H
		MOV A,M
		OUT 05H
		INX H
		MOV A,M
		OUT 06H    ;Hasta aqui

RET


.END      ; Fin del Codigo
