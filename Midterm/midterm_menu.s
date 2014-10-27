/*Program links three files to create a menu*/
/*prog1.s, prog2.s, prog3.s are linked*/

.data

message1: .asciz "Press 1 for Program 1: Calculates gross pay. \n" 

message2: .asciz "Press 2 for Program 2: Calculates ISP monthly bill. \n" 

message3: .asciz "Press 3 for Program 3: Calculates term in Fibonacci sequence. \n" 

message4: .asciz "Press any number key to terminate menu. \n" 

input: .asciz "%d" 

.text 

.global main
main: 
	push {lr} 						/*Push lr to the stack*/

	ldr r0, address_of_message1 	/*Load into r0 address_of_message1 as first parameter of printf*/ 
	bl printf 						/*Call printf*/ 
	
	ldr r0, address_of_message2 	/*Load into r0 address_of_message2 as first parameter of printf*/ 
	bl printf 						/*Call printf*/ 
	
	ldr r0, address_of_message3 	/*Load into r0 address_of_message3 as first parameter of printf*/ 
	bl printf 						/*Call printf*/ 
	
	ldr r0, address_of_message4 	/*Load into r0 address_of_message4 as first parameter of printf*/ 
	bl printf 						/*Call printf*/ 

	sub sp, sp, #4 					/*Make room in the stack for input*/ 
	
choice_input: 
	ldr r0, address_of_input 		/*Load into r0 input as first parameter of scanf*/ 
	mov r1, sp 						/*Move stack to r0 as second parameter of scanf*/ 
	bl scanf 						/*Call scanf*/ 
	
	ldr r0, [sp] 					/*Load into r0 input read*/ 
	add sp, sp, #+4 				/*Discard input from the stack*/ 
	
	cmp r0, #1
	beq program1
	
	cmp r0, #2
	beq program2
	
	cmp r0, #3 
	beq program3
	b end_main
	
program1:
	bal prog1
	b choice_input
	
program2: 
	bal prog2
	b choice_input
	
program3:
	bal prog3
	b choice_input 

end_main:
	pop {lr} 						/*pop lr from the stack*/ 
	bx lr							/*Leave Main*/ 

address_of_message1: .word message1
address_of_message2: .word message2 
address_of_message3: .word message3 
address_of_message4: .word message4 
address_of_input: .word input 
