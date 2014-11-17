/*program 7a*/
/*  https://github.com/ml1150258/LehrMark_CSC11_48598  */

.data

message1: .asciz "Type in a number to convert to Celsius: "

inputf: .asciz "%d"

message2: .asciz "The converion to Celsius is: %d \n" 

.text



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
	mov r2, #9 							/*Move 9 to r2*/
	
	bl divfun 							/*Call division function*/
	
	mov r2, r1 							/*Move division to r2 as third parameter of scanf*/
	mov r1, r0 							/*Move remainder to r1 as second parameter of scanf*/
	
	ldr r0, address_of_message2 		/*Load first parameter of printf to r0*/
	bl printf 							/*Call printf*/
	
	pop {lr}
	bx lr
	
address_of_message1: .word message1
address_of_message2: .word message2
address_of_inputf: .word inputf
