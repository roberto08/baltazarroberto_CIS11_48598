/*Program calculates a customers ISP monthly bill*/
/*a=97, b=98, c=99*/

.data 

message1: .asciz "a) $30 per month, 11 hours access. Additional hours are $3 up to 22 hours \n then $6 for all additional hours. \n"

message2: .asciz "b) $35 per month, 22 hours access. Additional hours are $2 up to 44 hours \n then $4 for each hour above this limit. \n"

message3: .asciz "c) $40 per month, 33 hours access. Additional hours are $1 up to 66 hours \n then $2 for each hour above this limit. \n" 

message4: .asciz "Please input number of hours will be used: \n" 

message5: .asciz "Please Enter a, b, or c for the package you would like to subscribe to: \n" 

message6: .asciz "Your monthly bill is: $%d \n" 

input_hours: .asciz "%d" 

input_choice: .asciz "%d" 

.text

/*First parameter r0 = price per month*/ 
/*Second parameter r1 = input hours*/ 
/*Third parameter r2 = first hours of access*/ 
/*Fourth parameter r3 = price per each additional hour*/ 
/*Fifth parameter r4 = max hours*/ 
/*Sixth parameter r5 = price per each additional past max*/ 
/*r0 returns bill price*/ 
bill:
	push {r1, r2, r3, r4, r5, lr} 	/*Push lr, r5, r4, r3, r2, and r1 to the stack*/ 
	
	cmp r1, r2  					/*Compare r1 and r2 for a normal rate*/
	ble end_bill  					/*If normal rate, branch to end_bill*/ 
	
	cmp r1, r4 						/*Compare r1 and r4 for extra charge*/ 
	ble extra 						/*If extra, branch to extra*/ 
	b max 							/*Otherwise branh to max charge*/ 
	
extra:
	sub r1, r1, r2 					/*Calculate extra hours to be charged*/ 
	mla r0, r3, r1, r0 				/*Calculate extra charge*/ 
	b end_bill  					/*branch to end_bill*/
	
max:
	sub r1, r1, r4 					/*Calculate extra hours to be charged*/
	mla r0, r5, r1, r0 	 			/*Calculate extra charge*/ 
	mov r1, r4  					/*Move r4 (hours) max to calculate secong extra charge*/ 
	b extra   						/*branch to extra to calculate the full charge*/ 
	
end_bill: 
	pop {r1, r2, r3, r4, r5, lr} 	/*Pop r4, r5 and lr back to its original values*/ 
	bx lr 							/*Exit function bill*/
	
.global prog2
prog2:
	push {lr} 						/*Push lr to the stack*/ 
	
	ldr r0, address_of_message1		/*Load into r0 address_of_message1 as first parameter of printf*/
	bl printf 						/*Call printf*/
	
	ldr r0, address_of_message2 	/*Load into r0 address_of_message2 as first parameter of printf*/
	bl printf 						/*Call printf*/
	
	ldr r0, address_of_message3 	/*Load into r0 address_of_message3 as first parameter of printf*/
	bl printf						/*Call printf*/

	ldr r0, address_of_message4 	/*Load into r0 address_of_message4 as first parameter of printf*/ 
	bl printf 						/*Call printf*/ 
	
	sub sp, sp, #4 					/*Make room in the stack for user input hours*/ 
	
	ldr r0, address_of_input_hours 	/*Load input as first parameter of scanf*/ 
	mov r1, sp 						/*Move the stack to r1 as second parameter of scanf*/ 
	bl scanf 						/*Call scanf*/ 

input_message:	
	ldr r0, address_of_message5 	/*Load into r0 address_of_message5 as first parameter of printf*/
	bl printf 						/*Call printf*/
	
	sub sp, sp, #4 					/*Make room in the stack for user input a, b, or c*/
	
	ldr r0, address_of_input_choice /*Move address_of_input to r0 as first parameter of scanf*/
	mov r1, sp 						/*Set the top of stack as second parameter of scanf*/ 
	bl scanf 						/*Call scanf*/
	
	ldr r0, [sp] 					/*Load the the top of the stack(user input) to r0*/
	
	add sp, sp, #+4 				/*Discard user input from the stack*/
	
	cmp r0, #1 						/*Compare r0(user input) to a(97)*/
	beq input_a 					/*If equal branch to input_a*/
	
	cmp r0, #2 						/*Compare r0(user input) to b(98)*/
	beq input_b 					/*If equal branch to input_b*/
	
	cmp r0, #3 						/*Compare r0(user input) to c(99)*/ 
	beq input_c 					/*If equal branch to input_c*/
	
	b input_message 				/*Other wise branch back to input_message*/

input_a:  							/*set parameters to call function*/ 
	mov r0, #30  					/*Move $30 per month to r0*/
	
	ldr r1, [sp] 					/*Load to r1 the input of hours*/
	add sp, sp, #+4  				/*Discard the input of hours from the stack*/ 
	
	mov r2, #11 					/*Move first 11 hours access*/ 
	mov r3, #3 						/*Move $3 to r2 for additional hours*/ 
	mov r4, #22 					/*Move 22 as max hours to r4*/ 
	mov r5, #6  					/*Move $6 to r5 as max charge per hours*/
	
	bl bill
    b end 
	
input_b: 							/*set parameters to call function*/ 
	mov r0, #35  					/*Move $35 per month to r0*/
	
	ldr r1, [sp] 					/*Load to r1 the input of hours from the stack*/
	add sp, sp, #+4 				/*Discard the input of hours from the stack*/
	 
	mov r2, #22 					/*Move first 22 hours access*/ 
	mov r3, #2 						/*Move $2 to r2 for additional hours*/ 
	mov r4, #44 					/*Move 44 as max hours to r4*/ 
	mov r5, #4  					/*Move $4 to r5 as max charge per hours*/
	
	bl bill
    b end 
	
input_c: 							/*set parameters to call function*/ 
	mov r0, #40  					/*Move $40 per month to r0*/
	
	ldr r1, [sp] 					/*Load to r1 the input of hours from the stack*/
	add sp, sp, #+4  				/*Discard the input of hours from the stack*/ 
	
	mov r2, #33 					/*Move first 33 hours access*/ 
	mov r3, #1 						/*Move $1 to r2 for additional hours*/ 
	mov r4, #66 					/*Move 66 as max hours to r4*/ 
	mov r5, #2  					/*Move $2 to r5 as max charge per hours*/
	
	bl bill

end: 
    mov r1, r0 						/*Move calculated bill to r1 as second parameter of printf*/ 
	
	ldr r0, address_of_message6 	/*Move address_of_message6 to r0 as first parameter of printf*/
	bl printf 						/*Call printf*/

	pop {lr} 						/*Pop lr to top of the stack*/ 
@	bx lr 							/*Leave main*/

address_of_message1: .word message1 
address_of_message2: .word message2 
address_of_message3: .word message3 
address_of_message4: .word message4 
address_of_message5: .word message5
address_of_message6: .word message6 
address_of_input_hours: .word input_hours 
address_of_input_choice: .word input_choice 
