/* divide input a and b */

	.global _start 
_start: 
	mov r1, #49 		/* input a */ 
	mov r2, #5 		/* input b */ 

	add r0, r1, r2 
	swi 0 
