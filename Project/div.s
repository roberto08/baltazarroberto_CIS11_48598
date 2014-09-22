/* divide input a and b */
	.global _start
_start:
	mov r0, #11				/*input a*/
	mov r1, #5				/*input b*/
	mov r2, #0 				/*clear the counter register*/

compare:
	cmp r0, r1				/*compare input a and b*/
	bneq subtract
	beq counter
	
subtract:	
	sub r0, r0, r1
	add r2, r2, #1	
	ret compare
	
counter:
    mov r0, r2	
	
	mov r7, #1
	swi 0
