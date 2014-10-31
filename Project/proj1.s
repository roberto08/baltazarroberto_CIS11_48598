/*Project 1*/ 
/*Mastermind*/
/* -- randTest.s */

.data

message1: .asciz "The 1 random function returned %d\n" 
message2: .asciz "The 2 random function returned %d\n" 
message3: .asciz "The 3 random function returned %d\n" 
message4: .asciz "The 4 random function returned %d\n" 

.text

random_number:
	push {r4,lr} 				/* Push lr onto the top of the stack */
	
	cmp r4, #4
	beq loop_rand 
	
	mov r0,#0 					/* Set time(0) */
	bl time 					/* Call time */
	bl srand 					/* Call srand */
	mov r4,#0 					/* Setup loop counter */
	
loop_rand: 						/* Create a 2 digit random number */
	bl rand 					/* Call rand */
	
	mov r1,r0,ASR #1 			/* In case random return is negative */
	
	mov r2,#10 					/* Move 90 to r2 */
								/* We want rand()%90+10 so cal divMod with rand()%90 */
								
	bl divMod 					/* Call divMod function to get remainder */
@	add r1,#1 					/* Remainder in r1 so add 10 giving between 10 and 99 -> 2 digits */
@	ldr r0, address_of_message1 /* Set &message2 as the first parameter of printf */
@	bl printf 					/* Call printf */
	
	add r4, r4, #1
	cmp r4,#20
	blt loop_rand 

	pop {r4,lr} 				/* Pop the top of the stack and put it in lr */
	bx lr 						/* Leave main */

.global main 
main: 
	push {lr} 					/* Push lr on top of the stack*/
	
	bl random_number
	
	ldr r0, address_of_message1
	bl printf
	
	mov r4, #4
	bl random_number
	
	ldr r0, address_of_message2
	bl printf
	
	mov r4, #4
	bl random_number
	
	ldr r0, address_of_message3
	bl printf
	
	mov r4, #4
	bl random_number
	
	ldr r0, address_of_message4
	bl printf
	
	pop {lr} 					/* Pop to top of the stack and put it in lr*/
	bx lr

address_of_message1: .word message1
address_of_message2: .word message2
address_of_message3: .word message3
address_of_message4: .word message4

/*External Functions*/
.global printf
.global time
.global srand
.global rand
