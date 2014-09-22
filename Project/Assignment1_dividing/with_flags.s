/* divide input a and b with the flag a/b*/
/*outputs r0 -> a/b*/
	.global _start
	
_start:
	mov r0, #0				/*clear the counter register*/
	mov r1, #11				/*input a*/
	mov r2, #5 				/*input b*/

compare:
	cmp r1, r2				/*compare input a and b*/
	bpl subtract			/*branch to subtract, if positive integer or greater than input b*/
	bmi exit				/*if less than input b or negative, branch to exit*/
	
subtract:	
	sub r1, r1, r2			/*subtract input a from b and update register 0*/
	add r0, r0, #1			/*update the counter or answer of the division*/
	b compare				/*branch back to compare*/
	
exit:
	
	mov r7, #1
	swi 0
