/* divide input a and b */
	.global _start
_start:
	mov r0, #11
	mov r1, #5
	adds r0, r1, r0
	
	mov r7, #1
	swi 0
