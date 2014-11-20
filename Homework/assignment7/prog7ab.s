/*program 7a*/
/*  https://github.com/ml1150258/LehrMark_CSC11_48598  */

.data

message1: .asciz "Type in a number to convert to Celsius: "

inputf: .asciz "%d"

message2: .asciz "The converion to Celsius is: %d\n" 

.text

tempconversion:
	push {r0, r2, r3, lr} 				/*Push r2, r3, and lr to the stack*/
	
	Sub r1, r1, #32 					/*Subtract 32 from temperature input*/
	
	ldr r0, =0x8e38f					/*Move 5/9 to r2*/
	mov r2, r0, lsr#20 					/*Rotate right 20 bits to turn into integer*/
	
	mul r1, r0, r2 						/*Multiply (f-32)*5/9*/

@	mov r1, r1, lsr#20 					/*Rotate right 20 bits to turn into integer*/
	
	pop {r0, r2, r3, lr} 				/*Pop r2, r3 and lr from the stack*/
	bx lr 								/*End function and return to main*/

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
	
@	sub r1, r1, #32 					/*Subtract fahrenheit input - 32*/
	
@	mov r2, #5 							/*Move 5 to r2 to use multiplication*/
@	mul r1, r2, r1 						/*Multiply subtracted input by 5*/
	
@	mov r2, #9 							/*Move 9 to r2*/
	
@	bl divfun 							/*Call division function*/

	bl tempconversion 					/*Call function to convert to Celsius*/
	
@	mov r2, r1 							/*Move division to r2 as third parameter of scanf*/
@	mov r1, r0 							/*Move remainder to r1 as second parameter of scanf*/
	
	ldr r0, address_of_message2 		/*Load first parameter of printf to r0*/
	bl printf 							/*Call printf*/
	
	pop {lr} 							/*Pop lr from the stack*/
	bx lr 								/*End main*/
	
address_of_message1: .word message1
address_of_message2: .word message2
address_of_inputf: .word inputf
