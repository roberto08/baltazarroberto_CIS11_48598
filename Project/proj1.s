/*Project 1*/ 
/* -- randTest.s */

.data

message1: .asciz "The random function returned %d\n" 

message2: .asciz "The Dealer cards: %d \n"

.text

random_number:
	push {r4,lr} 				/* Push lr onto the top of the stack */
	mov r0,#0 					/* Set time(0) */
	bl time 					/* Call time */
	bl srand 					/* Call srand */
	mov r4,#0 					/* Setup loop counter */
	
@loop_rand: 						/* Create a 2 digit random number */
	bl rand 					/* Call rand */
	
	mov r1,r0,ASR #1 			/* In case random return is negative */
	
	mov r2,#11 					/* Move 90 to r2 */
								/* We want rand()%90+10 so cal divMod with rand()%90 */
								
	bl divMod 					/* Call divMod function to get remainder */
	add r1,#1 					/* Remainder in r1 so add 10 giving between 10 and 99 -> 2 digits */
mov r8, r1
	ldr r0, address_of_message1 /* Set &message2 as the first parameter of printf */
	bl printf 					/* Call printf */
	
@	add r4,#1
@	cmp r4,#5
@	blt loop_rand 

	pop {r4,lr} 				/* Pop the top of the stack and put it in lr */
	bx lr 						/* Leave main */

.global main 
main: 
	push {lr} 					/* Push lr on top of the stack*/
	
	bl random_number 
	mov r1, r8
	
	ldr r0, address_of_message1 
	bl printf 
	
	bl random_number
	mov r1, r8
	
	ldr r0, address_of_message2
	bl printf
	
	pop {lr} 					/* Pop to top of the stack and put it in lr*/
	bx lr

address_of_message1: .word message1
address_of_message2: .word message2

/*External Functions*/
.global printf
.global time
.global srand
.global rand
