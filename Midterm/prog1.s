/*Program develops gross pay for employees*/
/*Pays straight time for 20 hours worked*/
/*Pays double time for all hours over 20 but less than 40*/
/*Pays triple time for hours over 40but less than 60 as maximum*/

.data 
 
message1: .asciz "How many hours did you worked this week? (note: 60 hours max) \n"

input_hours: .asciz "%d"

message2: .asciz "What is your pay rate? \n"

pay_rate: .asciz "%d"

message3: .asciz "Your gross pay is $%d \n"

.text

multiplication:
	push {lr} 						/*Push lr to the stack*/
	
	mul r0, r1, r0 					/*Multiply hours * pay into r0 = gross pay*/
	
	pop {lr} 						/*Pop lr from the stack*/
	bx lr 							/*Leave multiplication*/
	
rate:
	push {lr}

	mov r5, r0 			/*move pay rate to r5*/
	mov r6, r1 			/*move hours to r6*/
	mov r7, #0
	mov r8, #0
	mov r9, #0
	
	cmp r6, #20 		/*if pay rate equal less than 20*/
	ble straight
	
	cmp r6, #40 		/*if pay rate equal less than 40*/
	ble double
	
	cmp r6, #60
	ble triple

straight:
	mul r7, r1, r6 		@calculate overtime pay
	bl add_pay
	
double:
	sub r6, r6, #20 	@double hours to be paid
    mov r1, r1, lsl#1 		@double pay rate
	mul r8, r1, r6 		@calculate overtime pay
	mov r6, #20 		@restore first 20 hours
	b straight
	
triple:
	sub r6, r6, #40 	@triple hours to be paid
    add r1, r1, r1, lsl#1 		@triple pay rate
	mul r9, r1, r6 		@calculate overtime pay
	mov r6, #40 		@restore first 40 hours
    b double
	
add_pay:
	add r0, r7, r8
	add r0, r0, r9
	
end:	
	pop {lr}
	bx lr
	
.global main
main: 
	push {lr}						/*Push lr to the stack*/
	
	ldr r0, address_of_message1 	/*Load message1 to r0 as parameter of printf*/
	bl printf						/*Call printf*/
	
	sub sp, sp, #4 					/*Make room in the stack for hours input*/
	ldr r0, address_of_input_hours 	/*Load address_of_input_hours to r0 as first parameter of scanf*/
	mov r1, sp						/*Move top of the stack as second parameter of scanf (hours)*/
	bl scanf 						/*Call scanf*/
		
@	ldr r0, [sp]  					/*load r0 with hours inputed*/
@	bl rate 						/*Call rate*/
@	sub sp, sp, #4 					/*Make room in stack for type of rate*/
@	str r1, [sp] 					/*Push type of rate to stack*/
	
	ldr r0, address_of_message2 	/*Load message2 to r0 as parameter of printf*/
	bl printf 						/*Call printf*/
	
	sub sp, sp, #4 					/*Make room in the stack for pay rate input*/
	
	ldr r0, address_of_pay_rate		/*Load address_of_pay_rate to r0 as first parameter of scanf*/
	mov r1, sp 						/*Move top of the stack as second parameter of scanf (pay rate)*/
	bl scanf 						/*Call to scanf*/

	ldr r0, [sp]					/*Load into r0 the Pay rate read by scanf*/
	add sp, sp, #+4 				/*Discard the pay rate read by scanf*/
@	ldr r1, [sp]  					/*Load r1 with type of rate*/
@	add sp, sp, #+4 				/*Discard type of rate*/
@	bl multiplication 				/*Call multiplication*/
	
@	mov r1, r0 						/*Move final pay rate to r1*/
	
	ldr r1, [sp] 					/*Load into r1 the hours read by scanf*/
	add sp, sp, #+4 				/*Discard hours read by scanf*/
	
	bl rate
	
@	bl multiplication 				/*Call multiplication*/
	
	mov r1, r0 						/*Move gross pay into r1 as second parameter of printf*/
	
	ldr r0, address_of_message3  	/*Load address_of_message3 to r0 as first parameter of printf*/
	bl printf 						/*Call printf*/
	
	pop {lr} 						/*Pop lr to top of the stack*/
	bx lr 							/*Leave main*/
	
address_of_message1: .word message1
address_of_message2: .word message2
address_of_message3: .word message3
address_of_input_hours: .word input_hours
address_of_pay_rate: .word pay_rate
