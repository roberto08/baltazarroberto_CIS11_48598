/*Project 1*/ 
/*Mastermind*/
/*To run: as -o proj1.o proj1.s, as -o divfun.o divfun.s, gcc -o proj1 proj1.o divfun.o*/

.data

message1: .asciz "Mastermind: Type in your 4 digit code: "
input: .asciz "%d"
message2: .asciz "Your code is %d %d " 
message3: .asciz "%d %d\n"

.text

.global main 
main: 
	push {lr} 					/*Push lr on top of the stack*/
	
	ldr r0, address_of_message1
	bl printf
	
	mov r4, #0
user_input:	
	sub sp, sp, #4 				/*Make room in the stack for user input*/
	ldr r0, address_of_input 	/*Load address_of_input1 to r0 as first parameter of scanf*/
	mov r1, sp 					/*Set the stack as the second parameter of scanf*/ 
	bl scanf 					/*Call scanf*/
	
	add r4, r4, #1 				/*Update loop counter*/
	cmp r4, #4					/*Check for the four inputs*/
	blt user_input				/*If negative, loop back to user_input*/
		
@	sub sp, sp, #4 				/*Make room in the stack for user input*/
@	ldr r0, address_of_input 	/*Load address_of_input2 to r0 as first parameter of scanf*/
@	mov r1, sp 					/*Set the stack as the second parameter of scanf*/
@	bl scanf 					/*Call scanf*/
	
@	sub sp, sp, #4 				/*Make room in the stack for user input*/
@	ldr r0, address_of_input 	/*Load address_of_input3 to r0 as first parameter of scanf*/
@	mov r1, sp 					/*Set the stack as the second parameter of scanf*/
@	bl scanf 					/*Call scanf*/
	
@	sub sp, sp, #4 				/*Make room in the stack for user input*/
@	ldr r0, address_of_input 	/*Load address_of_input4 to r0 as first parameter of scanf*/
@	mov r1, sp 					/*Set the stack as the second parameter of scanf*/
@	bl scanf 					/*Call scanf*/

	ldr r8, [sp] 				/*Load user input4 to r4*/
	add sp, sp, #+4 			/*Discard the input from the stack*/
	
	ldr r7, [sp]				/*Load user input3 to r3*/
	add sp, sp, #+4				/*Discard the input from the stack*/
	
	ldr r2, [sp]				/*Load user input2 to r2*/
	add sp, sp, #+4				/*Discard the input from the stack*/
	
	ldr r1, [sp] 				/*Load user input1 to r1*/
	add sp, sp, #+4				/*Discard the input from the stack*/

	ldr r0, address_of_message2 /*Print out the correct answer*/
	bl printf
	
	mov r2, r8
	mov r1, r7 
	ldr r0, address_of_message3 /*Print out the correct answer*/
	bl printf
	
	pop {lr} 					/* Pop to top of the stack and put it in lr*/
	bx lr

address_of_message1: .word message1
address_of_input: .word input
address_of_message2: .word message2
address_of_message3: .word message3
