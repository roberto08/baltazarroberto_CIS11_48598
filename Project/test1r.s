.data

message2: .asciz "Your code is %d %d " 
message3: .asciz "%d %d\n"

.text

random_number:
	push {r2, r3, r4, lr} 		/*Push lr, r4, and ,r2 onto the top of the stack*/
	
	cmp r4, #4 					/*Test to see if this is the first time random is being called*/
	beq loop_rand  				/*If second time or more jump to loop_rand*/
	
	mov r0,#0 					/*Set time(0)*/
	bl time 					/*Call time*/
	bl srand 					/*Call srand*/
	mov r4,#0 					/*Setup loop counter*/
	
loop_rand: 						/*Create a 2 digit random number*/
	bl rand 					/*Call rand*/
	
	mov r1,r0,ASR #1 			/*In case random return is negative*/
	
	mov r2,#10 					/*Move 10 to r2 so random number ranges from 0 to 9*/

	bl divMod 					/*Call divMod function to get remainder*/
	
	add r4, r4, #1 				/*Update the loop counter*/
	cmp r4,#23
	blt loop_rand
	
	pop {r2, r3, r4, lr} 		/*Pop the top of the stack and put it in lr*/
	bx lr 						/*Leave main*/

.global main 
main: 
	push {r0, r1, r2, r3, r4, r5, r6, r7, r8, lr} /*Push lr on top of the stack*/

	mov r5, #0
rand_num:
	bl random_number			/*Call the random number generator*/
	sub sp, sp, #4				/*Make room in the stack for number returned*/
	str r1, [sp]				/*Store number in the stack*/
	mov r4, #4 					/*Move 4 to r4 for test in rand function*/
	add r5, r5, #1 				/*Update loop counter*/
	cmp r5, #4 					/*Chech for four number*/
	blt rand_num				/*If negative, continue to get number*/
	
@	mov r4, #4 					/*Move 4 to r4 to reset loop counter on random function*/
@	bl random_number			/*Call the random number generator*/
@	sub sp, sp, #4				/*Make room in the stack for number returned*/
@	str r1, [sp] 				/*Store the number in the stack*/
	
@	mov r4, #4					/*Move 4 to r4 to reset loop counter on random function*/
@	bl random_number 			/*Call the random number generator*/
@	sub sp, sp, #4				/*Make room in the stack for the number returned*/
@	str r1, [sp]				/*Store the number in the stack*/

@	mov r4, #4					/*Move 4 to r4 to reset loop counter on random function*/
@	bl random_number			/*Call the random number generator*/
@	sub sp, sp, #4				/*Make room in the stack for the number returned*/
@	str r1, [sp]				/*Store the number in the stack*/
	
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
	
	ldr r0, address_of_message2 /*Print out the correct answer*/
	bl printf
	
	mov r1, r7					/*Move correct answer to r3*/
	mov r2, r8					/*Move correct answer to r4*/

	ldr r0, address_of_message3 /*Print out the correct answer*/
	bl printf
	
	pop {r0, r1, r2, r3, r4, r5, r6, r7, r8, lr} /* Pop to top of the stack and put it in lr*/
	bx lr

address_of_message2: .word message2
address_of_message3: .word message3
