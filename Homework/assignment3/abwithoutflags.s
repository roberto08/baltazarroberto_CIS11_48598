/* divide input a and b without the flag a/b*/
/*outputs r0 -> a/b*/

	.global main
	
main:
	mov r2, #232			/*input a*/
	mov r3, #17 			/*input b*/
	mov r4, #0				
	mov r5, #0 				 
	mov r6, #0 				/*present scale of 10^*/
	mov r7, #0 				/*subtraction scale factor, r3*r6*/
	mov r8, #10 			/*shift factor 10*/
	mov r9, #0 				/*shift test r7*r8*/
	mov r0, #0				/*answer of a/b*/
	mov r1, r2 				/*remainder of 1%b*/
	
compare:
	cmp r2, r3				/*compare input a and b*/
	bge scale				/*branch to scale, if greater than input b*/
	ble end					/*if less than input b branch to end*/
	
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
	
end:
	bx lr
