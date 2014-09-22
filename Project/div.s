/* divide input a and b with the flag a%b*/
	.global _start
	
_start:
	mov r0, #11				/*input a*/
	mov r1, #5				/*input b*/
	mov r2, #0 				/*clear the counter register*/

compare:
	cmp r0, r1				/*compare input a and b*/
	bpl subtract			/*branch to subtract, if positive integer or greater than input b*/
	bmi counter				/*if less than input b or negative, branch to counter*/
	
subtract:	
	sub r0, r0, r1			/*subtract input a from b and update register 0*/
@	add r2, r2, #1			/*update the counter or answer of the division*/
	b compare				/*branch back to compare*/
	
counter:
@    mov r0, r1				/*moves the counter or answer to register 0*/
	
	mov r7, #1
	swi 0
