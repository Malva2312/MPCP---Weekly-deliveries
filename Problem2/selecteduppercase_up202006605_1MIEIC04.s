.text
.global SelectedUpperCase
.type SelectedUpperCase, "function"

//x0 = endereço inicial de B const
//x1 = endereço inicial de A const
//w2 = char de A
//w3 = char de B


SelectedUpperCase:	eor w5,w5,w5 //init count
					B START
LOOP:				add x1, x1, 1
START:				LDRB w3 , [x1]
					CBZ w3, END

					mov x8, x0

NESTED:				LDRB w2, [x8]
					CBZ w2, LOOP
					CMP w2, w3
					B.NE JUMP
					add w5,w5, 1
					sub w2,w2,32
					STRB w2, [x1]
JUMP: 				add x8, x8, 1
					B NESTED

END:				mov w0, w5
					ret
