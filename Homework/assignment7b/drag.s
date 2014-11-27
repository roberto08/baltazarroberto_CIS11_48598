/*program 7b*/
/*Program calculates drag calculation*/

.data

message1: .asciz "Enter the velocity and radius to calculate drag: "

message2: .asciz "The calculation for drag is: %d\n" 

vinput: .asciz "%d"

rinput: .asciz "%d"

.text

square:
/*Calculates the square of an integer*/
/*Receives one parameter in r1 and returns calculation in r1*/

	push {r0,r2,lr} 	/*Push r0, r2, and lr to the stack*/
 	
	mov r0, #1 			/*Set up counter*/
	mov r2, r1 			/*Make a copy of the integer*/
	
 update_square:
	add r1, r1, r2 		/*Add integer*/
	
	add r0, r0, #1 		/*Update the counter*/
	cmp r0, r2			/*Compare, if not zero update the square*/
	blt update_square

	pop {r0,r2,lr} 		/*pop r0, r2, and lr from the stack*/
	bx lr				/*Return to main*/
	
drag:
/*Calculates drag*/
/*Drag=(1/2)*e*v^2*A(pi*r^2)*Cd
/*Receives two parameters in r1 (velocity) and r2 (radius) and returns calculation in r1*/

	push {r0,r2,r5,r6,r7,r11,r12,lr} 			/*Push lr to the stack*/
	
	mov r11, r1 		/*Move velocity to r11*/
	mov r12, r2 		/*Move radius to r12*/
	ldr r5, =0x9b5 		/*Load into r3 the value of density*/	
	ldr r6, =0x324 		/*Load into r4 the value of pi*/
	ldr r7, =0x666 		/*Load into r5 the value of drag*/

	bl square
	mov r11, r1 		/*Move squared velocity to r11*/
	
	mov r1, r12 		/*Move radius to r1*/
	bl square
	mov r12, r1 		/*Move squared radius to r12*/
	
	mul r3, r5, r11 	/*Multiply velocity times density*/
	
	mov r0, r3, lsr#20
	
	mov r1, r0, asr#1 	/*Multiply times 1/2 previous answer*/
	
@	mul r3, r6, r11 	/*Multiply pi times radius*/
	
@	mov r0, r3, asr#20
	
@	mul r3, r7, r0 		/*Multiply previous answer times drag*/
	
@	mov r0, r3, asr#12
	
@	mul r1, r0, r1 		/*Multiply both answers in r1 and r0 to r1*/
	
	pop {r0,r2,r5,r6,r7,r11,r12,lr} 			/*Pop lr to the stack*/
	bx lr 				/*Return to main*/
	
.global main
main:

	push {lr} 			/*Push lr to the stack*/
	
	ldr r0, address_of_message1 		/*Load into r0 address_of_message1 as parameter*/
	bl printf 			/*Call printf*/
	
	sub sp, sp, #4 		/*Make room in the stack for the input*/
	ldr r0, address_of_vinput 			/*Load into r0 address_of_vinput as parameter*/
	mov r1, sp 			/*Move the stack to r1 as second parameter of scanf*/
	bl scanf
	
	sub sp, sp, #4 		/*Make room in the stack for the input*/
	ldr r0, address_of_rinput 			/*Load into r0 address_of_rinput as parameter*/
	mov r1, sp 			/*Move the stack to r1 as second parameter of scanf*/
	bl scanf

	ldr r1, [sp] 		/*Load velocity the input read to r1*/
	add sp, sp, #4 		/*Discard the number read from the stack*/
	
	ldr r2, [sp] 		/*Load radius the input read to r2*/
	add sp, sp, #4 		/*Discard the number read from the stack*/
	
	bl drag 			/*Call the drag function*/
	
	ldr r0, address_of_message2 		/*Load into r0 address_of_message2 as parameter*/
	bl printf
	
	pop {lr} 			/*Pop lr to the stack*/
	bx lr
 
address_of_message1: .word message1
address_of_message2: .word message2
address_of_vinput: .word vinput
address_of_rinput: .word rinput
