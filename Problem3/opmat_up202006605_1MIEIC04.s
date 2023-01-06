.text
.global OpMat
.type OpMat, "function"

//w0 = nº de colunas
//w1 = nº de linhas
//x2 = base da seq de operações
//x3 = base da seq da matrizbase da seq de operações

//w4 = operação  //op1
//x5 = offset

OpMat: 	stp x29, x30, [SP, -64]!
		mov w10, -1
OpMat1:	ldrb w4, [x2], #1

		CMP w4, #88 //'X'
		B.EQ END

		CMP w4, #76//'L'
		B.EQ L

		CMP w4, #67//C
		B.EQ C

		CMP w4, #80//P
		B.EQ P

		CMP w4, #66//B
		B.EQ B

		CMP w4, #79//O
		B.EQ O

		B OpMat1

END:	ldp x2, x3, [SP, 16]
		ldp x29, x30, [SP], #64
		mov w0, w10 // wrong
		ret

L:		ldrb w4, [x2], #1
		ldrb w5, [x2], #1
		eor  w6, w6, w6  //contador
		umaddl x7, w4, w0, x3
LOOP_L:	CMP w6, w0
		B.EQ OpMat1
		add w6, w6, #1
		strb w5, [x7], #1
		B LOOP_L

C:		ldrb w4, [x2], #1
		ldrb w5, [x2], #1
		eor w6, w6, w6  //contador
		add w6, w6, #1
		umaddl x7, w6, w4, x3
		sub w6, w6, #1
		mov w4, 1
LOOP_C:	CMP w6, w1
		B.EQ OpMat1
		add w6,w6,#1
		strb w5, [x7]
		umaddl x7, w0, w4, x7
		B LOOP_C

P:		ldrb w4, [x2], #1
		ldrb w5, [x2], #1
		ldrb w6, [x2], #1
		mov w11, 1
		umaddl x7, w11, w4, x3
		umaddl x7, w0, w5, x7
		strb w6, [x7]
		B OpMat1

B:		mov x7, x3
		eor x6,x6,x6
		umaddl x5, w0 ,w1,x6

LOOP_B:	CMP x5, x6
		B.EQ OpMat1
		add x6, x6, #1

		ldrb w4, [x7]
		CMP w4, #127
		mov w4, #255
		B.HI JUMP
		mov w4, #0
JUMP:	strb w4, [x7], #1
		B LOOP_B

O:		//guardar registos
		ldrb w4, [x2], #1

		stp x2, x3, [SP, 16]
		stp x0, x1, [SP, 32]

		mul w6, w0, w1

		mov w0, w4
		mov x1, x3
		mov w2, w6
//////////////////////////////////////
		BL ocorr
////////////////////////////////////
		//B END //wrong
		mov w10, w0
		LDP x0, x1, [SP, 32]
		LDP x2, x3, [SP, 16]
		B OpMat1
//


