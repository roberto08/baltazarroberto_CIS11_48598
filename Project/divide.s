	.global _start
_start:
	mov r0, #65
	mov r1, #5

	sub ro, r0, r1
	swi 0
