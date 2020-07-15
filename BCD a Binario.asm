.ORG 000H

  MVI H, 10H                      ;INICIALIZAMOS H EN 10H, ESTE REGISTRO LO USAREMOS ASI A LOS LARGO DE TODO EL PROGRAMA
  MVI L, 50H                      ;APUNTAMOS L A LA POSCISION 50H
  ;Entra el primer numero
  IN 08H                          ;ENTRA PRIMER NUMERO EN BCD
  CPI 10H                         ;COMPARAMOS SI LUEGO DE LA MASCARA EL RESULTADO NO ES IGUAL A CERO
JC NoHayConversion                ;SI EL RESULTADO ES CERO ESTO SIGNIFICA QUE NO ES NECESARIO HACER UNA CONVERSION

  MOV B, A                        ;GUARDAMOS EL NUMERO EN EL REGISTRO B
  ANI F0H													;hacemos una mascara para los bits de menor peso
  RRC                             ;DESPLAZAMOS EL NUMERO 4 VECES A LA DERECHA PARA OBTENER LAS DECENAS
  RRC
  RRC
  RRC
  MOV D, A                        ;GUARDAMOS EL DATO A DECREMENTAR EN EL REGISTRO D
  BCDaBinario: MOV A, C           ;TRAEMOS EL DATO A SUMAR DEL REGISTRO C
    ADI 06H                       ;LE SUMAMOS UN 06H
    MOV C, A                      ;GUARDAMOS EL DATO EN C Nuevamente
    DCR D                         ;DECREMENTAMOS EL REGISTRO D
    MOV A, D                      ;MOVEMOS EL DATO AL Acumulador
    CPI 00H                       ;LO COMPARAMOS CON 00H
  JNZ BCDaBinario

  MOV A, B                        ;FINALMENTE RECUPERAMOS EL NUMERO ORIGINAL
  SUB C                           ;LE RESTAMOS LO NECESARIO PARA LA CONVERSION BCD/BCDaBinario

NoHayConversion: MOV M, A         ;Y GUARDAMOS EL DATO CONVERTIDO EN LA POSICION DE MEMOARIA 1050H

  ;Entra el segundo numero
  IN 09H           ;ENTRA PRIMER NUMERO EN BCD
  CPI 10H                         ;COMPARAMOS SI LUEGO DE LA MASCARA EL RESULTADO NO ES IGUAL A CERO
JC NoHayConversion2               ;SI EL RESULTADO ES CERO ESTO SIGNIFICA QUE NO ES NECESARIO HACER UNA CONVERSION
  MOV B, A                        ;GUARDAMOS EL NUMERO EN EL REGISTRO B
  ANI F0H												  ;hacemos una mascara para los bits de menor peso
  RRC                             ;DESPLAZAMOS EL NUMERO 4 VECES A LA DERECHA PARA OBTENER LAS DECENAS
  RRC
  RRC
  RRC
  MOV D, A                        ;GUARDAMOS EL DATO A DECREMENTAR EN EL REGISTRO D
  MVI C, 00H                      ;INICIAMOS C EN 00H POR SI QUEDO ALGUN NUMERO DE LA CONVERSION ANTERIOR
  BCDaBinario2: MOV A, C          ;TRAEMOS EL DATO A SUMAR DEL REGISTRO C
    ADI 06H                       ;LE SUMAMOS UN 06H
    MOV C, A                      ;GUARDAMOS EL DATO EN C Nuevamente
    DCR D                         ;DECREMENTAMOS EL REGISTRO D
    MOV A, D                      ;MOVEMOS EL DATO AL Acumulador
    CPI 00H                       ;LO COMPARAMOS CON 00H
  JNZ BCDaBinario2

  MOV A, B                        ;FINALMENTE RECUPERAMOS EL NUMERO ORIGINAL
  SUB C                           ;LE RESTAMOS LO NECESARIO PARA LA CONVERSION BCD/BCDaBinario

NoHayConversion2: INR L
  MOV M, A                        ;Y GUARDAMOS EL DATO CONVERTIDO EN LA POSICION DE MEMOARIA 1051H


  HLT

.END
