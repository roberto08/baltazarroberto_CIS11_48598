	.global _start
_start:
	mov r1, #65
	mov r2, #5

	add r0, r1, r2
	swi 0
