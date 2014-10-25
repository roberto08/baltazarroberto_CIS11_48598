/*Program develops gross pay for employees*/
/*Pays straight time for 20 hours worked*/
/*Pays double time for all hours over 20 but less than 40*/
/*Pays triple time for hours over 40but less than 60 as maximum*/

.data 
 
message1: .asciz "How many hours did you worked this week? \n"

input_hours: .asciz "%d"

message2: .asciz "What is your pay rate? \n"

@input_pay_rate: .asciz "%d"

message3: .asciz "Your rate pay is $%d \n"

.text

multiplication:
	push {r0, r1, lr} 				/*Push lr, r1, r0 to the stack*/
	
	mul r0, r1, r0 					/*Multiply hours * pay into r0 = gross pay*/
	
	pop {r0, r1, lr} 				/*Discard r0, r1 and pop lr to the top*/
	bx lr 							/*Leave multiplication*/

.global main
main: 
	push {r1, r2, lr}						/*Move lr to the top of the stack*/
	
	ldr r0, address_of_message1 	/*Load message1 to r0 as parameter of printf*/
	bl printf						/*Call printf*/
	
	ldr r0, address_of_input_hours 	/*Load address_of_input_hours to r0 as first parameter of scanf*/
@	push {r1} 						/*Move r1 to top of the stack as second parameter of scanf*/
	bl scanf 						/*Call scanf*/
	
	ldr r0, address_of_message2 	/*Load message2 to r0 as parameter of printf*/
	bl printf 						/*Call printf*/
	
	ldr r0, address_of_input_hours 	/*Load address_of_pay_rate to r0 as first parameter of scanf*/
	mov r2, r1 						/*Move pay rate read (second parameter) r1 into r2*/
@	push {r2}						/*Move r2 to top of the stack as second parameter of scanf*/
	bl scanf 						/*Call to scanf*/
	
	ldr r0, [sp]					/*Load into r0 the Pay rate read by scanf*/
	ldr r1, [sp] 					/*Load into r1 the hours read by scanf*/
	
	bl multiplication 				/*Call multiplication*/
	
	mov r1, r0 						/*Move gross pay into r1 as second parameter of printf*/
	
	ldr r0, address_of_message3  	/*Load address_of_message2 to r0 as first parameter of printf*/
	bl printf 						/*Call printf*/
	
	pop {r1, r2, lr} 				/*Discard integer read and pop lr to top of the stack*/
	bx lr 							/*Leave main*/
	
address_of_message1: .word message1
address_of_message2: .word message2
address_of_message3: .word message3
address_of_input_hours: .word input_hours
@address_of_pay_rate: .word input_pay_rate
