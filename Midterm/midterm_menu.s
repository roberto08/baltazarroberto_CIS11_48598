/*Program links three files to create a menu*/
/*prog1.s, prog2.s, prog3.s are linked*/

.data

message1: .asciz "Press 1 for Program 1: Calculates gross pay. \n" 

message2: .asciz "Press 2 for Program 2: Calculates ISP monthly bill. \n" 

message3: .asciz "Press 3 for Program 3: Calculates term in Fibonacci sequence. \n" 

message4: .asciz "Press any key to terminate menu. \n" 

input: .asciz "%d" 

.text 

.global main
main: 

	ldr r0, address_of_message1 	/*Load into r0 address_of_message1 as first parameter of printf*/ 
	bl printf 						/*Call printf*/ 
	
	ldr r0, address_of_message2 	/*Load into r0 address_of_message2 as first parameter of printf*/ 
	bl printf 						/*Call printf*/ 
	
	ldr r0, address_of_message3 	/*Load into r0 address_of_message3 as first parameter of printf*/ 
	bl printf 						/*Call printf*/ 
	
	ldr r0, address_of_message4 	/*Load into r0 address_of_message4 as first parameter of printf*/ 
	bl printf 						/*Call printf*/ 

choice_input: 
	ldr r0, address_of_input 		/*Load into r0 input as first parameter of scanf*/ 
	bl scanf 						/*Call scanf*/ 
	
	cmp r1, #1
	beq program1
	
	cmp r1, #2
	beq program2
	
	cmp r1, #3 
	beq program3
	bal end 
	
program1:
	bal prog1
	bal choice_input
	
program2: 
	bal prog2
	bal choice_input
	
program3:
	bal prog3
	bal choice_input 

end:
	bx lr

address_of_message1: .word message1
address_of_message2: .word message2 
address_of_message3: .word message3 
address_of_message4: .word message4 
address_of_input: .word input 
