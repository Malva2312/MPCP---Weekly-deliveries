.text
.global histo
.type histo, "function"

//w0 = tamanho de C				( é multiplo de 16 )
//x1 = endereço base de C		( 1 byte por elemento )
//x2 = endereço base de H		( tamanho de H = 21 && 1 byte por elemento)

//x3 = valor da nota
//w5 =
//w7 =tamanho de C

// (nota + endereço de H) = elemento a incrementar em H

//multiplo de 16 ( = 16 * n), logo vou usar um quad n vezes

histo:	mov w6, #0
		mov w7, w0
		mov x15, x1
		eor x3, x3, x3
LOOP:	CBZ w7, END
		sub w7, w7, #16

		ldr q1, [x1],#16
		mov w4, #16

FOO:	CBZ w4, HERE
		sub w4, w4, 1

		ldrb w3, [x15], #1

		ldrb w11, [x2, x3]
		add w11, w11, #1
		strb w11, [x2, x3]

		B FOO

HERE:	addv b1, V1.16B
		umov w5, V1.B[0]
		add w6, w5, w6

		B LOOP

END: 	UCVTF s0, w6
		UCVTF s1, w0
		fdiv s0, s0, s1
		ret
