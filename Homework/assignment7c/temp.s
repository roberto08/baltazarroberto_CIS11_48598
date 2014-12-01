/*program 7c*/
/*Program converts Fahrenheit to Celsius degrees*/
/*Uses a temperature conversion function*/

.data

message1: .asciz "Type in a number to convert to Celsius: "

inputf: .asciz "%d"

message2: .asciz "The conversion to Celsius is: %f\n" 

value1: .float 0.555556

.text

tempconversion:
/*Converts Fahrenheit to Celsius degrees*/
/*Function receives one parameter in r1 and returns conversion in r1*/

	push {r0, r2, lr} 					/*Push r2, r3, and lr to the stack*/
	
	Sub r0, r1, #32 					/*Subtract 32 from temperature input*/
	
@	ldr r2, =0x8e38f					/*Move 5/9 to r2*/

	ldr r1, address_of_value1 			/*Load address of value in r0*/
	vldr s14, [r1] 						/*Move value into s14*/
	vcvt.f64.f32 d5, s14 				

	vmov s8, r0
	
	vmul.f32 s2, s8, d5  				/*Multiply (f-32)*5/9*/

	ldr r0, address_of_message2 		/*Load first parameter of printf to r0*/
	vmov r2, r3, s2 					/*Load value*/
	bl printf 							/*Call printf*/
	
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

@	ldr r0, address_of_message2 		/*Load first parameter of printf to r0*/
@	bl printf 							/*Call printf*/
	
	pop {r0, r1, lr} 					/*Pop lr from the stack*/
	bx lr 								/*End main*/
	
address_of_message1: .word message1
address_of_message2: .word message2
address_of_inputf: .word inputf
address_of_value1: .float value1 
