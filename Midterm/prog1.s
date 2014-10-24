/*Program develops gross pay for employees*/
/*Pays straight time for 20 hours worked*/
/*Pays double time for all hours over 20 but less than 40*/
/*Pays triple time for hours over 40but less than 60 as maximum*/

.data 
 
message1: .asciz "How many hours did you worked this week? \n"

message2: .asciz "Your rate pay is $ \n"

.text

.global main
main: 
	push {lr}
	
	ldr r0, address_of_message1
	bl printf
	
	ldr r0, address_of_message2
	bl printf
	
	pop {lr}
	bx lr
	
address_of_message1: .word message1
address_of_message2: .word message2
