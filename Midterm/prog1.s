/*Program develops gross pay for employees*/
/*Pays straight time for 20 hours worked*/
/*Pays double time for all hours over 20 but less than 40*/
/*Pays triple time for hours over 40but less than 60 as maximum*/

.data 
 
message1: .asciz "How many hours did you worked this week? \n"

input_hours: .asciz "%d"

message2: .asciz "Your rate pay is $%d \n"

.text

.global main
main: 
	push {r1, lr}
	
	ldr r0, address_of_message1
	bl printf
	
	ldr r0, address_of_input_hours 
	mov r1, sp
	bl scanf
	
	ldr r1, [sp]
	
	ldr r0, address_of_message2
	bl printf
	
	pop {r1, lr}
	bx lr
	
address_of_message1: .word message1
address_of_message2: .word message2
address_of_input_hours: .word input_hours
