/*program 7b*/
/*Program calculates drag calculation*/

.data

message1: .asciz "Enter the velocity and radius to calculate drag:\n"

message2: .asciz "The calculation for drag is: %d\n" 

vinput: .asciz "%d"

rinput: .asciz "%d"

.text

square:
/*Calculates the square of an integer*/
/*Receives one parameter in r1 and returns calculation in r1*/

	push {r0,r2,lr} 	/*Push r0, r2, and lr to the stack*/
 	
	mov r0, r1 			/*Set up counter*/
	mov r2, r1 			/*Make a copy of the integer*/
	
 update_square:
	add r1, r1, r2 		/*Add integer*/
	
	sub r0, r0, #1 		/*Update the counter*/
	cmp r0, #0 			/*Compare, if not zero update the square*/
	bne update_square

	pop {r0,r2,lr} 		/*pop r0, r2, and lr from the stack*/
	bx lr				/*Return to main*/
	
.global main
main:

	push {lr} 			/*Push lr to the stack*/
	
	ldr r0, address_of_message1 		/*Load into r0 address_of_message1 as parameter*/
	bl printf 			/*Call printf*/
	
	sub sp, sp, #4 		/*Make room in the stack for the input*/
	ldr r0, address_of_vinput 			/*Load into r0 address_of_vinput as parameter*/
	mov r1, sp 			/*Move the stack to r1 as second parameter of scanf*/
	bl scanf
	
	ldr r1, [sp] 		/*Load the input read to r1*/
	add sp, sp, #4 		/*Discard the number read from the stack*/
	
	bl square 			/*Call the square function*/
	
	ldr r0, address_of_message2 		/*Load into r0 address_of_message2 as parameter*/
	bl printf
	
	pop {lr} 			/*Pop lr to the stack*/
	bx lr
 
address_of_message1: .word message1
address_of_message2: .word message2
address_of_vinput: .word vinput
address_of_rinput: .word rinput
