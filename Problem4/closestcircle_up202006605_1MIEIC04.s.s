.text
.global closestCircle
.type closestCircle, "function"

// w0 = nº de pontos (unsigned int)  =    NP
// x1 = endereço de do vetor de pontos				precisão simples
// w2 = nº de centros (unsigned int)	= NC
// x3 = endereço do vetor de centros				precisão dupla
// x4 = endereço da sequência a editar

closestCircle:	B SET
MAIN_LOOP:		ADD x4, x4, #4
SET:			CBZ w0, END
				sub w0, w0, #1

				ldr s0, [x1], #4	//x
				ldr s1, [x1], #4 	//y

				FCVT d0, s0
				FCVT d1, s1
				mov x11, x3		//copy of Vcentros
				mov w7, w2
				eor w6,w6,w6		//init Vc index counter
				B SET_UP

NEXT_C:			ADD w6,w6, #1
SET_UP:			CBZ w7, MAIN_LOOP
				SUB w7, w7, #1

				ldr d2, [x11], #8	//xc
				ldr d3, [x11], #8	//yc
				ldr d4, [x11], #8	//R


				FSUB d5, d0, d2		// x - xc
				FMUL d5, d5, d5		// (x - xc)^2

				FSUB d6, d1, d3		// y - yc
				FMUL d6, d6, d6		// (y - yc)^2

				FADD d5, d5, d6		// (x - xc)^2 + (y - yc)^2
				FSQRT d5, d5		// sqrt((x - xc)^2 + (y - yc)^2)

				FSUB d5, d5, d4

				FCMP d5, #0.0
				B.LE NEXT_C

				ldr w5 , [x4]
				CMP w5, #-1
				B.EQ Do_It

				FCMP d5, d7
				B.GT NEXT_C

Do_It:			FMOV d7, d5
				str w6, [x4]
				B NEXT_C

END: 			ret




/*
////////////////////////////   SET ID TO -1 ////////////////////////

SET:			mov w5, w0 //w5 = vezes a executar
				mov x6, x4	//x6 = copia do end ID
				mov w7, #-1	//

SET_1:			CBZ w5, READY
				sub w5, w5, #1

				str w7,[x6], #4
				B SET_1
////////////////////////////////////////////////////////////////////
*/
