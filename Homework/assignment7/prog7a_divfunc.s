/*program 7a*/
/*Program converts Fahrenheit to Celsius degrees*/
/*Uses division function*/

.data

message1: .asciz "Type in a number to convert to Celsius: "

inputf: .asciz "%d"

message2: .asciz "The converion to Celsius is: %d with remainder %d \n" 

.text

scaleright:
	push {lr} 				/* Push lr onto the stack */
	dowhile_r1_lt_r2: 		/* Shift right until just under the remainder */
	mov r3,r3,ASR #1; 		/* Division counter */
	mov r2,r2,ASR #1 		/* Mod/Remainder subtraction */
	cmp r1,r2
	blt dowhile_r1_lt_r2
	pop {lr} 				/* Pop lr from the stack */
	bx lr 					/* Leave scaleRight */

addsub:
	push {lr} 				/* Push lr onto the stack */
	dowhile_r3_ge_1:
	add r0,r0,r3
	sub r1,r1,r2
	bl scaleright
	cmp r3,#1
	bge dowhile_r3_ge_1
	pop {lr} 				/* Pop lr from the stack */
	bx lr 					/* Leave addSub */

scaleleft:
	push {lr} 				/* Push lr onto the stack */
	dowhile_r1_ge_r2: 		/* Scale left till overshoot with remainder */
	mov r3,r3,LSL #1 		/* scale factor */
	mov r2,r2,LSL #1 		/* subtraction factor */
	cmp r1,r2
	bge dowhile_r1_ge_r2 	/* End loop at overshoot */
	mov r3,r3,ASR #1 		/* Scale factor back */
	mov r2,r2,ASR #1 		/* Scale subtraction factor back */
	pop {lr} 				/* Pop lr from the stack */
	bx lr 					/* Leave addSub */

divfunction:
	push {lr} 				/* Push lr onto the stack */
							/* Determine the quotient and remainder */
	mov r0,#0
	mov r3,#1
	cmp r1,r2
	blt end
	bl scaleleft
	bl addsub
	
	end:
	pop {lr} 				/* Pop lr from the stack */
	bx lr					/* Leave addSub */

.global main
main: 

	push {lr} 							/*Push lr to the stack*/
	
	ldr r0, address_of_message1 		/*Load first parameter of printf to r0*/
	bl printf 							/*Call printf*/ 
	
	sub sp, sp, #4 						/*Make room in the stack for fahrenheit input*/
	ldr r0, address_of_inputf 			/*Load address and first parameter of scanf to r0*/
	mov r1, sp 							/*Move the stack to r1 as second parameter of scanf*/
	bl scanf

	ldr r1, [sp] 						/*Load the input read to r1*/
	add sp, sp, #4 						/*Discard the number read from the stack*/
	
	sub r1, r1, #32 					/*Subtract fahrenheit input - 32*/
	
	mov r2, #5 							/*Move 5 to r2 to use multiplication*/
	mul r1, r2, r1 						/*Multiply subtracted input by 5*/
	
	mov r2, #9 							/*Move 9 to r2*/
	
	bl divfunction 						/*Call division function*/
	
	mov r2, r1 							/*Move division to r2 as third parameter of scanf*/
	mov r1, r0 							/*Move remainder to r1 as second parameter of scanf*/
	
	ldr r0, address_of_message2 		/*Load first parameter of printf to r0*/
	bl printf 							/*Call printf*/
	
	pop {lr} 							/*Pop lr from the stack*/
	bx lr								/*End main*/
	
address_of_message1: .word message1
address_of_message2: .word message2
address_of_inputf: .word inputf
