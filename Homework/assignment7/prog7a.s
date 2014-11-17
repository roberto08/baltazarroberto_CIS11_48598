/*program 7a*/
/*  https://github.com/ml1150258/LehrMark_CSC11_48598  */

.data

message1: .asciz "Type in a number to convert to Celsius: "

inputf: .asciz "%d \n"

message2: .asciz "The converion to Celsius is: %d \n" 

.text



.global main
main: 

	push {lr} 							/*Push lr to the stack*/
	
	ldr r0, address_of_message1 		/*Load first parameter of printf to r0*/
	bl printf 							/*Call printf*/ 
	
@	sub sp, sp, #4 						/*Make room in the stack for fahrenheit input*/
	ldr r0, address_of_inputf 			/*Load address and first parameter of scanf to r0*/
	bl scanf
	
	ldr r1, address_of_inputf
	
	ldr r0, address_of_message2 		/*Load first parameter of printf to r0*/
	bl printf 							/*Call printf*/
	
	pop {lr}
	bx lr
	
address_of_message1: .word message1
address_of_message2: .word message2
address_of_inputf: .word inputf
