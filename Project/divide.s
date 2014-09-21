	.global _start
_start:
	mov r0, #65
	mov r1, #5

	sub r0, r0, r1
	swi 0
