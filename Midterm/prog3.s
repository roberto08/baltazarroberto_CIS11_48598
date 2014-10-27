/*Program generates the Fibonacci sequence*/ 
/*The input will be the term the sequence to output*/ 
/*The output will be that term in the sequence*/ 

.data

message1: .asciz "Enter a number: \n" 

message2: .asciz "The term in the Fibonacci sequence is: %d \n \n" 

input: .asciz "%d" 

.text

.global prog3
prog3:
	push {lr} 						/*Push lr to the stack*/ 
	
	ldr r0, address_of_message1 	/*Load address_of_message1 to r0 as first parameter of printf*/
	bl printf 						/*Call printf*/ 
	
	sub sp, sp, #4 					/*Make room in the stack for the number input*/ 
	
	ldr r0, address_of_input 		/*Load address_of_input to r0 as first parameter of scanf*/ 
	mov r1, sp 						/*Move stack to r1 as second parameter of scanf*/ 
	bl scanf 						/*Call scanf*/
	
	ldr r0, [sp] 					/*Move the number input to r0*/
	
	add sp, sp, #+4 				/*Discard the number input from stack*/ 
	
	mov r1, #0 						/*Move 0 as the first term into r1*/ 
	mov r2, #1 						/*Move 1 as the second term into r2*/ 
	
update: 	
	add r1, r1, r2 					/*Update the next term (first) in the sequence of r1*/ 
	cmp r1, r0 						/*Compare number input to first number in sequence*/ 
	bge move1 						/*If greater or equal to input branch to output*/ 
	
	add r2, r1, r2 					/*Update the next term (second) in the sequence of r2*/ 
	cmp r2, r0 						/*Compare number input to second number in sequence*/ 
	bge output   					/*If greater or equal to input branch to move1*/ 
	b update 
	
move1: 
	mov r1, r2 						/*Move r2 to r1 to make as second parameter for scanf*/ 
	
output: 
	ldr r0, address_of_message2 	/*Load address_of_message2 to r0 as first parameter*/ 
	bl printf 						/*Call printf*/
	
	pop {lr} 						/*Pop lr to the top of the stack*/ 
	bal main 
	
address_of_message1: .word message1 
address_of_message2: .word message2 
address_of_input: .word input 
