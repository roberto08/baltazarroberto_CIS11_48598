	.global _start
_start:
	mov r0, #65
	mov r7, #5

	add r0, r0, r7
	swi 0
