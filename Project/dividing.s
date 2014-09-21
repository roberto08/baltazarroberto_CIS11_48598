/* Assignment 2 divides inputs a/b and a%b without flag set */

	.global _start

_start:
	
	mov r0, #11
	mov r1, #5
	
	@sub r0, r0, r1
swi 0
