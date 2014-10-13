/* divide input a and b*/
/*output a/b and a%b*/

.data

.balign 4				/*First Message*/
message1: .asciz "The quotient is %d"

.balign 4				/*Second Message*/
message2: .asciz "The numerator is %d"

.balign 4
return: .word 0

.text

.global main
divide:	
  main:
	mov r2, #526				/*input a*/
	mov r3, #9	 			/*input b*/
	mov r4, #0 				/*use to flag a%b*/
	mov r5, #0 				/*use to swap ro <-> r1*/
	mov r6, #0 				/*present scale of 10^*/
	mov r7, #0 				/*subtraction scale factor, r3*r6*/
	mov r8, #10 			/*shift factor 10*/
	mov r9, #0 				/*shift test r7*r8*/
	mov r0, #0				/*answer of a/b*/
	mov r1, r2 				/*remainder of 1%b*/
	
compare:
	cmp r2, r3				/*compare input a and b*/
	bge scale				/*branch to scale, if greater than input b*/
	ble move_answers			/*if less than input b branch to check_flag*/
	
scale:
	mov r6, #1 				/*present scale of 10^*/
	mul r7, r3, r6 			/*subtraction factor*/ 
	mul r9, r7, r8 			/*test subtraction factor*/
	cmp r1, r9 				/*test to shift scale by 10*/
	blt subtract 			/*branch to subtract if remainder greater than shift test*/
	
scale_update:
	mul r6, r8, r6 			/*update scale factor*/
	mul r7, r3, r6 			/*subtraction factor*/
	mul r9, r7, r8 			/*test subtraction factor*/
	cmp r1, r9
	bge scale_update 		/*branch back to scale*/

subtract:
	add r0, r0, r6			/*update the counter/answer by scale */
	sub r1, r1, r7			/*subtract input by scale*/
	cmp r1, r7				/*if subtraction scale factor greater than a%b branch to subtract*/
	bge subtract
	cmp r6, #1				/*if scale greater than 1 branch back to scale*/
	bgt scale
	
@  check_flag:
@	cmp r4, r1 				/*check for a%b*/
@	bgt screen_out 				/*if no remainder branch to end*/
	
@	mov r5, r0 				/*move a/b to temporary register*/
@	mov r0, r1				/*move to r0 a%b*/
@	mov r1, r5				/*move a/b to r1 and complete switch*/

move_answers:
   mov r10, r0
   mov r11, r1
   
screen_out:
	ldr r1, address_of_return
	str lr, [r1]
	
	mov r1, r10
	ldr r0, address_of_message1
	bl printf

	mov r1, r11
	ldr r0, address_of_message2
	bl printf
	
	ldr lr, address_of_return
	ldr lr, [lr]
	
end:
	bx lr

address_of_message1: .word message1
address_of_message2: .word message2
address_of_return: .word return
@address_of_input1: .word input1
@address_of_input2: .word input2

.global printf

