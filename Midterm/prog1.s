/*Program develops gross pay for employees*/
/*Pays straight time for 20 hours worked*/
/*Pays double time for all hours over 20 but less than 40*/
/*Pays triple time for hours over 40 but less than 60 as maximum*/

.data 
 
message1: .asciz "How many hours did you worked this week? (note: 60 hours max) \n"

input_hours: .asciz "%d"

message2: .asciz "What is your pay rate? \n"

pay_rate: .asciz "%d"

message3: .asciz "Your gross pay is $%d \n"

.text
	
/*first parameter r0 = pay rate*/ 
/*second parameter r1 = hours*/ 
gross_pay: 
	push {r7, r8, r9, r10, lr} 		/*Push lr, r10, r9, r8, and r7 to the stack*/ 

	mov r7, #0 						/*Clear r7 for first 20 hours paid*/ 
	mov r8, #0 						/*Clear r8 for second 20 hours paid*/ 
	mov r9, #0 						/*Clear r9 for third 20 hours paid*/ 
	mov r10, r0 					/*Move to r10 to keep original pay rate*/
	
	cmp r1, #20 					/*Compare hours input to first 20 hours*/ 
	ble straight_pay 				/*If hours equal less than 20 branch to straight_pay*/
	
	cmp r1, #40 					/*Compare hours input to next 40 hours*/
	ble double_pay 					/*If hours equal less than 40 branch to double_pay*/
	
	cmp r1, #60 					/*Compare hours input to next 60 hours*/ 
	ble triple_pay 					/*If hours equal less than 60 hours branch to triple_pay*/

straight_pay:
	mul r7, r1, r0 					/*Calculate straight pay*/ 
	b add_pay 						/*Branch to add_pay*/ 
	
double_pay:
	sub r1, r1, #20 				/*Calculate double hours to be paid*/ 
    mov r0, r0, lsl#1 				/*Calculate double pay rate*/
	mul r8, r0, r1 					/*Calculate Double pay to r8*/
	mov r1, #20 					/*Restore first 20 hours*/
	mov r0, r10 					/*Move to r0 original pay rate*/
	b straight_pay 					/*Branch to straight_pay*/ 
	
triple_pay:
	sub r1, r1, #40 				/*Calculate triple hours to be paid*/
    add r0, r0, r0, lsl#1 			/*Calculate triple pay rate*/ 
	mul r9, r0, r1 					/*Calculate triple pay to r9*/ 
	mov r1, #40 					/*restore first 40 hours*/ 
	mov r0, r10 					/*Move to r0 original pay rate*/
    b double_pay					/*Branch to double_pay*/
	
add_pay:
	add r0, r7, r8 					/*Add to r0 straight pay and double pay*/ 
	add r0, r0, r9 					/*Add to r0 triple pay for gross pay*/ 
	
end:	
	pop {r7, r8, r9, r10, lr} 		/*Pop r7, r8, r9, r10 and lr from the stack*/ 
	bl lr 							/*Leave gross_pay*/ 
	
.global prog1
prog1: 
	push {r0, r1, lr}						/*Push lr to the stack*/
	
	ldr r0, address_of_message1 	/*Load message1 to r0 as parameter of printf*/
	bl printf						/*Call printf*/
	
	sub sp, sp, #4 					/*Make room in the stack for hours input*/
	ldr r0, address_of_input_hours 	/*Load address_of_input_hours to r0 as first parameter of scanf*/
	mov r1, sp						/*Move top of the stack as second parameter of scanf (hours)*/
	bl scanf 						/*Call scanf*/
		
	ldr r0, address_of_message2 	/*Load address_of_message2 to r0 as parameter of printf*/
	bl printf 						/*Call printf*/
	
	sub sp, sp, #4 					/*Make room in the stack for pay rate input*/
	
	ldr r0, address_of_pay_rate		/*Load address_of_pay_rate to r0 as first parameter of scanf*/
	mov r1, sp 						/*Move top of the stack as second parameter of scanf (pay rate)*/
	bl scanf 						/*Call to scanf*/

	ldr r0, [sp]					/*Load into r0 the Pay rate read by scanf*/
	add sp, sp, #+4 				/*Discard the pay rate read by scanf*/
	
	ldr r1, [sp] 					/*Load into r1 the hours read by scanf*/
	add sp, sp, #+4 				/*Discard hours read by scanf*/
	
	bl gross_pay
	
	mov r1, r0 						/*Move gross pay into r1 as second parameter of printf*/
	
	ldr r0, address_of_message3  	/*Load address_of_message3 to r0 as first parameter of printf*/
	bl printf 						/*Call printf*/
	
	pop {r0, r1, lr} 						/*Pop lr to top of the stack*/
	
address_of_message1: .word message1
address_of_message2: .word message2
address_of_message3: .word message3
address_of_input_hours: .word input_hours
address_of_pay_rate: .word pay_rate
