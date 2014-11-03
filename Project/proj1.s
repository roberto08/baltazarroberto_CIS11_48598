/*Project 1*/ 
/*Mastermind*/
/* -- randTest.s */

.data

message1: .asciz "Type in your 4 digit code: %d %d %d %d\n"
message5: .asciz "Your code is %d %d %d %d\n" 

.text

random_number:
	push {r2,r4,lr} 				/* Push lr onto the top of the stack */
	
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

	pop {r2,r4,lr} 				/* Pop the top of the stack and put it in lr */
	bx lr 						/* Leave main */

.global main 
main: 
	push {lr} 					/* Push lr on top of the stack*/
	
@	sub sp, sp, #16
	ldr r0, address_of_message1
	mov r1, #0
	mov r2, #0
	mov r3, #0
	mov r4, #0
	bl scanf
	
@	add sp, sp, #+4
	
	mov r8, #0
get_code:
	bl random_number

	sub sp, sp, #4
	str r1, [sp]
	mov r4, #4
	add r8, r8, #1
	cmp r8, #4
	ble get_code

	ldr r5, [sp]
	add sp, sp, #+4
	
	ldr r6, [sp]
	add sp, sp, #+4
	
	ldr r7, [sp]
	add sp, sp, #+4
	
	ldr r8, [sp] 
	add sp, sp, #+4
	
	add sp, sp, #+4
	
	mov r11, #0
	mov r12, #10
compare_digits:	
	cmp r1, r5
	addeq r11, r11, #1
	@addne r12, r12, #1
	movne r1, #0x58 @letter
	
	cmp r2, r6
	addeq r11, r11,	#1
	@addne r12, r12, #1
	movne r2, #0x58
	
	cmp r3, r7
	addeq r11, r11, #1
	@addne r12, r12, #1
	movne r3, #0x58
	
	cmp r8, r9
	addeq r11, r11, #1
	@addne r12, r12, #1
	movne r4, #0x58
	
	cmp r11, #4
	beq print_out_answer
	
	subs r12, r12, #1
	blt compare_digits
	
print_out_answer:
	ldr r0, address_of_message5
	bl printf
	
@	add sp, sp, #+4
	
	
	
@	ldr r0, address_of_message1
@	bl printf
	
@	mov r4, #4
@	bl random_number
	
@	ldr r0, address_of_message2
@	bl printf
	
@	mov r4, #4
@	bl random_number
	
@	ldr r0, address_of_message3
@	bl printf
	
@	mov r4, #4
@	bl random_number
	
@	ldr r0, address_of_message4
@	bl printf

	
	pop {lr} 					/* Pop to top of the stack and put it in lr*/
	bx lr

address_of_message1: .word message1
address_of_message5: .word message5

/*External Functions*/
.global printf
.global time
.global srand
.global rand
