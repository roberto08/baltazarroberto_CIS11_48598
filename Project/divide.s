/* divide input a and b */

	.global _start 
_start: 
	mov r0, #65 		/* input a */ 
	mov r1, #5 		/* input b */ 

	sub r0, r0, r1 
	swi 0 
