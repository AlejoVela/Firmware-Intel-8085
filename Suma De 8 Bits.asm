.ORG 1020H
  ;DATOS DE PRUEBA
  MVI H, 10H
  MVI L, 50H
  MVI M, 3EH                     ;62->3E
  INR L
  MVI M, 1EH                     ;30->1E
  ;TERMINAN DATOS DE PRUEBA


  MVI L, 50H                     ;UBICAMOS EL PRIMER NUMEROS
  MOV A, M                       ;TRAEMOS EL NUMERO AL Acumulador
  INR L                          ;AUMENTAMOS LA MEMORIA PARA LLEGAR AL SEGUNDO NUMEROS
  ADD M                          ;SUMAMOS LOS DOS numeros

  MVI L, 50H                     ;DIRECCIONAMOS A LA POSICION DE MEMORIA DEL PRIMER NUMERO
  MOV M, A                       ;AQUI GUARDAMOS EL RESULTADO

  ;CONVERTIMOS DE BINARIO A BCD

  ;ROTAMOS EN EL DISPLAY

  HLT                            ;TERMINAMOS EJECUCIÓN

.END
