/*Project 1*/ 
/*Mastermind*/

.data

message1: .asciz "Type in your 4 digit code:\n "
input1: .asciz "%d"
input2: .asciz "%d"
input3: .asciz "%d"
input4: .asciz "%d\n"
message2: .asciz "Your code is %d %d %d %d\n" 
message3: .asciz "Sorry, The answer is %d %d %d %d\n"
message4: .asciz "Congratulations!!! the code is %d %d %d %d\n"

.text

random_number:
	push {r2, r4, lr} 			/*Push lr, r4, and ,r2 onto the top of the stack*/
	
	cmp r4, #4 					/*Test to see if this is the first time random is being called*/
	beq loop_rand  				/*If second time or more jump to loop_rand*/
	
	mov r0,#0 					/*Set time(0)*/
	bl time 					/*Call time*/
	bl srand 					/*Call srand*/
	mov r4,#0 					/*Setup loop counter*/
	
loop_rand: 						/*Create a 2 digit random number*/
	bl rand 					/*Call rand*/
	
	mov r1,r0,ASR #1 			/*In case random return is negative*/
	
	mov r2,#10 					/*Move 10 to r2*/

	bl divMod 					/*Call divMod function to get remainder*/
	
	add r4, r4, #1 				/*Update the loop counter*/
	cmp r4,#20
	blt loop_rand 

	mov r0, r1
	
	pop {r2, r4, lr} 			/*Pop the top of the stack and put it in lr*/
	bx lr 						/*Leave main*/

.global main 
main: 
	push {lr} 					/*Push lr on top of the stack*/

	bl random_number			/*Call the random number generator*/
	sub sp, sp, #4				/*Make room in the stack for number returned*/
	str r0, [sp]				/*Store number in the stack*/
	
	mov r4, #4 					/*Move 4 to r4 to test for only rand in the function*/
	bl random_number			/*Call the random number generator*/
	sub sp, sp, #4				/*Make room in the stack for number returned*/
	str r0, [sp] 				/*Store the number in the stack*/
	
	mov r4, #4					/**Move 4 to r4 to test for only rand in the function*/
	bl random_number 			/*Call the random number generator*/
	sub sp, sp, #4				/*Make room in the stack for the number returned*/
	str r0, [sp]				/*Store the number in the stack*/

	mov r4, #4					/*Move 4 to r4 to test for only rand in the function*/
	bl random_number			/*Call the random number generator*/
	sub sp, sp, #4				/*Make room in the stack for the number returned*/
	str r0, [sp]				/*Store the number in the stack*/
	
	mov r10, #0 				/*Setup loop counter*/
user_input:	
	ldr r0, address_of_message1	/*Load address_of_message1 as first parameter of printf*/
	bl printf 					/*Call printf*/
	
	sub sp, sp, #4 				/*Make room in the stack for user input*/
	ldr r0, address_of_input1 	/*Load address_of_input1 to r0 as first parameter of scanf*/
	mov r1, sp 					/*Set the stack as the second parameter of scanf*/ 
	bl scanf 					/*Call scanf*/
		
	sub sp, sp, #4 				/*Make room in the stack for user input*/
	ldr r0, address_of_input2 	/*Load address_of_input2 to r0 as first parameter of scanf*/
	mov r1, sp 					/*Set the stack as the second parameter of scanf*/
	bl scanf 					/*Call scanf*/
	
	sub sp, sp, #4 				/*Make room in the stack for user input*/
	ldr r0, address_of_input3 	/*Load address_of_input3 to r0 as first parameter of scanf*/
	mov r1, sp 					/*Set the stack as the second parameter of scanf*/
	bl scanf 					/*Call scanf*/
	
	sub sp, sp, #4 				/*Make room in the stack for user input*/
	ldr r0, address_of_input4 	/*Load address_of_input4 to r0 as first parameter of scanf*/
	mov r1, sp 					/*Set the stack as the second parameter of scanf*/
	bl scanf 					/*Call scanf*/

	ldr r4, [sp] 				/*Load user input4 to r4*/
	add sp, sp, #+4 			/*Discard the input from the stack*/
	
	ldr r3, [sp]				/*Load user input3 to r3*/
	add sp, sp, #+4				/*Discard the input from the stack*/
	
	ldr r2, [sp]				/*Load user input2 to r2*/
	add sp, sp, #+4				/*Discard the input from the stack*/
	
	ldr r1, [sp] 				/*Load user input1 to r1*/
	add sp, sp, #+4				/*Discard the input from the stack*/
	
	cmp r10, #4 				/*Test to see if only gettin user input*/
	beq compare_digits
		
	ldr r8, [sp] 				/*Load random number to r8*/
	add sp, sp, #+4				/*Discard the number from the stack*/
	
	ldr r7, [sp]				/*Load random number to r*/
	add sp, sp, #+4				/*Discard the number from the stack*/
	
	ldr r6, [sp]				/*Load random number to r6*/
	add sp, sp, #+4				/*Discard the number from the stack*/
	
	ldr r5, [sp]				/*Load random number to r5*/
	add sp, sp, #+4				/*Discard the number from the stack*/
	
	
	mov r11, #0
	mov r12, #0
compare_digits:	
	cmp r1, r5 					/*Compare user input and random number*/
	addeq r11, r11, #1  		/*If Equal add 1 to r11 to test for right answer*/
	@addne r12, r12, #1
	movne r1, #11 @letter 		/*If not equal move 11 to r1 indicating wrong guess*/
	
	cmp r2, r6					/*Compare user input and random number*/
	addeq r11, r11,	#1			/*If Equal add 1 to r11 to test for right answer*/
	@addne r12, r12, #1
	movne r2, #11				/*If not equal move 11 to r1 indicating wrong guess*/
	
	cmp r3, r7					/*Compare user input and random number*/
	addeq r11, r11, #1			/*If Equal add 1 to r11 to test for right answer*/
	@addne r12, r12, #1
	movne r3, #11				/*If not equal move 11 to r1 indicating wrong guess*/
	
	cmp r4, r8					/*Compare user input and random number*/
	addeq r11, r11, #1			/*If Equal add 1 to r11 to test for right answer*/
	@addne r12, r12, #1
	movne r4, #11				/*If not equal move 11 to r1 indicating wrong guess*/
	
	cmp r11, #4 				/*Compare r11 to check if all correct answer*/
	beq print_out_win 			/*If all correct branch to win*/
	
	add r12, r12, #1 			/*Update the loop*/
	cmp r12, #3
	blt prepare_for_loop 		/*Check if any more tries left*/
	b print_out_answer			/*If all tries gone branch to print_out_answer*/
	
prepare_for_loop:	
	mov r10, #4 				/*Move 4 to r10 to only get user input*/
	mov r11, #0					/*Clear r11 to test for right digits again*/
	
	ldr r0, address_of_message2	/*Load address_of_message2 to r0 as first parameter of printf*/
	bl printf					/*Call printf*/
	b user_input 				/*Branch to user_input*/
	
print_out_answer: 
	mov r1, r5					/*Move correct answer to r1*/
	mov r2, r6					/*Move correct answer to r2*/
	mov r3, r7					/*Move correct answer to r3*/
	mov r4, r8					/*Move correct answer to r4*/
	
	ldr r0, address_of_message3 /*Print out the correct answer*/
	bl printf
	
	b end_game 					/*Branch to end_game*/
	
print_out_win:
	ldr r0, address_of_message4 /*Print out win message*/
	bl printf
	
end_game:
	pop {lr} 					/* Pop to top of the stack and put it in lr*/
	bx lr

address_of_message1: .word message1
address_of_input1: .word input1
address_of_input2: .word input2
address_of_input3: .word input3
address_of_input4: .word input4
address_of_message2: .word message2
address_of_message3: .word message3
address_of_message4: .word message4

/*External Functions*/
.global printf
.global time
.global srand
.global rand
