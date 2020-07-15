.ORG 100H     ; Directiva del Programa

 IN 00H			   ;Entra dato por puerto 00H
 MOV B,A			 ;Guardamos el dato en el registro B
 MVI D,0AH     ;Inicializamos el registro D con 0AH para los limites de 10

 C1:MOV A,B		 ;Recuperamos el dato de B en el acumulador (necesario para lo siguientes pasos)
  CMP D        ;Comparamos con D, si es menor saltamos al final y sumamos C que
 JC C2				 ;idealmente C debe valer cero para este caso

 MOV A,C	      ;Movemos el contenido de C al acumulador
	ADI 06H       ;Sumamos 06H a este contenido
 MOV C,A       ;Guardamos el resultado en C nuevamente
 MOV A,D       ;recuperamos el valor de D
	ADI 0AH       ;y le sumamos 0AH para la siguiente iteraci�n
	MOV D,A       ;Nuevamente guardamos el valor
 JMP C1          ;Nos de volvemos a C1

 C2: ADD C      ;Finalmente sumamos lo acumulado en C

 OUT 08H

HLT
.END
