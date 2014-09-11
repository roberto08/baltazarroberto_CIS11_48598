@ prog3a.s - a simple assembler file
/* This comment will be ignored by the assembler */
	.global _start
_start:
	MOV R0, #49 
	MOV R7, #1
	SWI 0
