
.data

message2: .asciz "Your code is %d %d %d %d\n" 

.text

random_number:
	push {r1, r2, r3, r4, lr} 		/*Push lr, r4, and ,r2 onto the top of the stack*/
	
	cmp r4, #4 					/*Test to see if this is the first time random is being called*/
	beq loop_rand  				/*If second time or more jump to loop_rand*/
	
	mov r0,#0 					/*Set time(0)*/
	bl time 					/*Call time*/
	bl srand 					/*Call srand*/
	
loop_rand: 						/*Create a 2 digit random number*/
	bl rand 					/*Call rand*/
	
	mov r1,r0,ASR #1 			/*In case random return is negative*/
	
	mov r2,#10 					/*Move 10 to r2*/

	bl divMod 					/*Call divMod function to get remainder*/

	mov r0, r1
	
	pop {r1, r2, r3, r4, lr} 		/*Pop the top of the stack and put it in lr*/
	bx lr 						/*Leave main*/

.global main 
main: 
	push {r0, r1, r2, r3, r4, lr} 					/*Push lr on top of the stack*/

	bl random_number			/*Call the random number generator*/
	sub sp, sp, #4				/*Make room in the stack for number returned*/
	str r0, [sp]				/*Store number in the stack*/
@	mov r1, r0
	
	mov r4, #4 					/*Move 4 to r4 to test for only rand in the function*/
	bl random_number			/*Call the random number generator*/
	sub sp, sp, #4				/*Make room in the stack for number returned*/
	str r0, [sp] 				/*Store the number in the stack*/
@	mov r2, r0
	
	mov r4, #4					/**Move 4 to r4 to test for only rand in the function*/
	bl random_number 			/*Call the random number generator*/
	sub sp, sp, #4				/*Make room in the stack for the number returned*/
	str r0, [sp]				/*Store the number in the stack*/
@	mov r3, r0

	mov r4, #4					/*Move 4 to r4 to test for only rand in the function*/
	bl random_number			/*Call the random number generator*/
	sub sp, sp, #4				/*Make room in the stack for the number returned*/
	str r0, [sp]				/*Store the number in the stack*/
@	mov r4, r0
	
		
	ldr r8, [sp] 				/*Load random number to r8*/
	add sp, sp, #+4				/*Discard the number from the stack*/
	
	ldr r7, [sp]				/*Load random number to r*/
	add sp, sp, #+4				/*Discard the number from the stack*/
	
	ldr r6, [sp]				/*Load random number to r6*/
	add sp, sp, #+4				/*Discard the number from the stack*/
	
	ldr r5, [sp]				/*Load random number to r5*/
	add sp, sp, #+4				/*Discard the number from the stack*/
	 
	mov r1, r5					/*Move correct answer to r1*/
	mov r2, r6					/*Move correct answer to r2*/
	mov r3, r7					/*Move correct answer to r3*/
	mov r4, r8					/*Move correct answer to r4*/
	
	ldr r0, address_of_message2 /*Print out the correct answer*/
	bl printf
	
	pop {r0, r1, r2, r3, r4, lr} 					/* Pop to top of the stack and put it in lr*/
	bx lr

address_of_message2: .word message2

