
.text

@.global scaleright
scaleRight:
	push {lr} 				/* Push lr onto the stack */
	dowhile_r1_lt_r2: 		/* Shift right until just under the remainder */
	mov r3,r3,ASR #1; 		/* Division counter */
	mov r2,r2,ASR #1 		/* Mod/Remainder subtraction */
	cmp r1,r2
	blt dowhile_r1_lt_r2
	pop {lr} 				/* Pop lr from the stack */
	bx lr 					/* Leave scaleRight */

@.global addsub
addsub:
	push {lr} 				/* Push lr onto the stack */
	dowhile_r3_ge_1:
	add r0,r0,r3
	sub r1,r1,r2
	bl scaleright
	cmp r3,#1
	bge dowhile_r3_ge_1
	pop {lr} 				/* Pop lr from the stack */
	bx lr 					/* Leave addSub */

@.global scaleleft
scaleleft:
	push {lr} 				/* Push lr onto the stack */
	dowhile_r1_ge_r2: 		/* Scale left till overshoot with remainder */
	mov r3,r3,LSL #1 		/* scale factor */
	mov r2,r2,LSL #1 		/* subtraction factor */
	cmp r1,r2
	bge dowhile_r1_ge_r2 	/* End loop at overshoot */
	mov r3,r3,ASR #1 		/* Scale factor back */
	mov r2,r2,ASR #1 		/* Scale subtraction factor back */
	pop {lr} 				/* Pop lr from the stack */
	bx lr 					/* Leave addSub */

.global divfunction
divfunction:
	push {lr} 				/* Push lr onto the stack */
							/* Determine the quotient and remainder */
	mov r0,#0
	mov r3,#1
	cmp r1,r2
	blt end
	bl scaleleft
	bl addsub
	
	end:
	pop {lr} 				/* Pop lr from the stack */
	bx lr					/* Leave addSub */
