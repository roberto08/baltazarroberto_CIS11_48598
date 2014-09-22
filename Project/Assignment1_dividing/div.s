/* divide input a and b without the flag a%b*/
	.global _start
	
_start:
	mov r0, #9				/*input a*/
	mov r1, #3				/*input b*/

compare:
	cmp r0, r1				/*compare input a and b*/
	bpl subtract			/*branch to subtract, if positive integer or greater than input b*/
	bmi exit				/*if less than input b or negative, branch to exit*/
	
subtract:	
	sub r0, r0, r1			/*subtract input a from b and update register 0*/
	b compare				/*branch back to compare*/
	
exit:
	mov r7, #1
	swi 0
