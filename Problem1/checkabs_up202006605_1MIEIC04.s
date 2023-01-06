.text
.global CheckABS
.type CheckABS, "function"

//w0 número
//w1 nº elenementos
//x2 endereço
//w3 nº loaded
//w5 contador


CheckABS:	eor w5,w5,w5	//init counter

MAIN_LOOP:	CBZ w1, END		//end loop if size == 0

			ldr w3, [x2]	//load sigle register
			CMP w3, 0		//compare
			B.GE NO_NEG		//step if no need to neg
			neg w3, w3		//aritemetic neg

NO_NEG:		CMP w0, w3
			B.GE STEP		//branch if doens match the condition

	//if match the condition executes// w0 <= x

			add w5,w5, 1	//add 1 to counter
			eor w3,w3,w3	//turn 0 the nº greater than w0
			str w3, [x2]	//store 0 in

STEP:		add x2, x2, 4	//next element
			add w1,w1,-1	//-1 in the size
			B MAIN_LOOP		//restar the loop

END:		mov w0, w5
			ret
