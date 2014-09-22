/* divide input a and b */
	.global _start
_start:
	mov r0, #11				/*input a*/
	mov r1, #5				/*input b*/
	
	cmp r0, r1
	sub r0, r0, r1
	
	mov r7, #1
	swi 0
