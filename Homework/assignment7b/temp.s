/*program 7b*/
/*Program converts Fahrenheit to Celsius degrees*/
/*Uses a temperature conversion function*/

.data

message1: .asciz "Type in a number to convert to Celsius: "

inputf: .asciz "%d"

message2: .asciz "The conversion to Celsius is: %d\n" 

.text

tempconversion:
/*Converts Fahrenheit to Celsius degrees*/
/*Function receives one parameter in r1 and returns conversion in r1*/

	push {r0, r2, lr} 					/*Push r2, r3, and lr to the stack*/
	
	Sub r1, r1, #32 					/*Subtract 32 from temperature input*/
	
	ldr r0, =0x8e38f					/*Move 5/9 to r2*/
	
	mov r3, r0, lsr#20 					/*Rotate right 20 bits to turn into integer*/
	
	mul r0, r1, r3 						/*Multiply (f-32)*5/9*/
	
	mov r1, r0

@	mov r1, r0, asr#20 					/*Rotate right 20 bits to turn into integer*/
	
	pop {r0, r2, lr} 					/*Pop r2, r3 and lr from the stack*/
	bx lr 								/*End function and return to main*/

.global main
main: 

	push {r0, r1, lr} 					/*Push lr to the stack*/
	
	ldr r0, address_of_message1 		/*Load first parameter of printf to r0*/
	bl printf 							/*Call printf*/ 
	
	sub sp, sp, #4 						/*Make room in the stack for Fahrenheit input*/
	ldr r0, address_of_inputf 			/*Load address and first parameter of scanf to r0*/
	mov r1, sp 							/*Move the stack to r1 as second parameter of scanf*/
	bl scanf

	ldr r1, [sp] 						/*Load the input read to r1*/
	add sp, sp, #4 						/*Discard the number read from the stack*/

	bl tempconversion 					/*Call function to convert to Celsius*/

	ldr r0, address_of_message2 		/*Load first parameter of printf to r0*/
	bl printf 							/*Call printf*/
	
	pop {r0, r1, lr} 					/*Pop lr from the stack*/
	bx lr 								/*End main*/
	
address_of_message1: .word message1
address_of_message2: .word message2
address_of_inputf: .word inputf
