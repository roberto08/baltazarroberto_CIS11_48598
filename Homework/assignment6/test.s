/* -- collatz02.s */
.data
time: .asciz "the time is %d\n"
.text

 .global main
 main:
    push {lr}                       /* keep lr */
	
	mov r0, #0
	bl time
	
	ldr r0, address_of_time
	bl printf

	pop {lr}
	bx lr

address_of_message: .word message 
address_of_scan_format: .word scan_format
address_of_message2: .word message2
address_of_time: .word time
