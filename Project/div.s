/* divide input a and b */
	.global _start
_start:
	mov r0, #11				/*input a*/
	mov r1, #5				/*input b*/
	
	mov r7, #1
	swi 0
