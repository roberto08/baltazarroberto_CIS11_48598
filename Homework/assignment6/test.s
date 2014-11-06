/* -- collatz02.s */
.data
time_ran: .asciz "the time is %d\n"
.text

 .global main
 main:
	
	mov r0, #0
	bl time
	
	mov r1, r0
	ldr r0, address_of_time_ran
	bl printf

	bx lr

address_of_time_ran: .word time_ran
