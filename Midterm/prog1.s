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
	push {r0, lr}

	cmp r0, #20
	ble straight
	
	cmp r0, #40
	ble double
	
	cmp r0, #60
	ble triple

straight:
	mov r1, #1
	ble end
	
double:
    mov r1, #2
	ble end
	
triple:
	mov r1, #3
	
end:	
	pop {r0, lr}
	bx lr
	
final_rate:

	
.global main
main: 
	push {r1, lr}					/*Push lr, r1 to the stack*/
	
	ldr r0, address_of_message1 	/*Load message1 to r0 as parameter of printf*/
	bl printf						/*Call printf*/
	
	ldr r0, address_of_input_hours 	/*Load address_of_input_hours to r0 as first parameter of scanf*/
	mov r1, sp						/*Move top of the stack as second parameter of scanf (hours)*/
	bl scanf 						/*Call scanf*/
	
	sub sp, sp, #4
	
	ldr r0, [sp] 
	mov r1, sp
	bl rate
	
	ldr r0, address_of_message2 	/*Load message2 to r0 as parameter of printf*/
	bl printf 						/*Call printf*/
	
	sub sp, sp, #4 					/*Make room in the stack for pay rate input*/
	
	ldr r0, address_of_pay_rate		/*Load address_of_pay_rate to r0 as first parameter of scanf*/
	mov r1, sp 						/*Move top of the stack as second parameter of scanf (pay rate)*/
	bl scanf 						/*Call to scanf*/

	ldr r0, [sp] 
	add sp, sp, #+4 
	ldr r1, [sp] 
	add sp, sp, #+4
	bl multiplication
	
@	ldr r0, [sp]					/*Load into r0 the Pay rate read by scanf*/
@	add sp, sp, #+4 				/*Discard the pay rate read by scanf*/
	ldr r1, [sp] 					/*Load into r1 the hours read by scanf*/
	
	bl multiplication 				/*Call multiplication*/
	
	mov r1, r0 						/*Move gross pay into r1 as second parameter of printf*/
	
	ldr r0, address_of_message3  	/*Load address_of_message3 to r0 as first parameter of printf*/
	bl printf 						/*Call printf*/
	
	pop {r1, lr} 					/*Discard integer read (hours) and pop lr to top of the stack*/
	bx lr 							/*Leave main*/
	
address_of_message1: .word message1
address_of_message2: .word message2
address_of_message3: .word message3
address_of_input_hours: .word input_hours
address_of_pay_rate: .word pay_rate
