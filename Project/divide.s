/* divide input a and b */

	.global _start 
_start: 
	mov r0, #49 		/* input a */ 
	mov r1, #5 		/* input b */ 

	add r0, r0, r1 
	swi 0 
