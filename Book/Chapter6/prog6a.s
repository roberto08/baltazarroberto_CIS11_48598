/*Program 6a. simple 32-bit addition*/
/*Perform r0=r1+r2*/

	.global _start:
_start:
	mov r1, #60 		/*get 50 into r1*/
	mov r2, #60 		/*get 50 into r2*/
	adds ro, r1, r2 	/*add the two, result in r0*/
	
	mov r7, #1 			/*exit through syscall*/
	swi 0
	