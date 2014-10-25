/*Program calculates a customers ISP monthly bill*/

.data 

message1: .asciz "a) $30 per month, 11 hours access. Additional hours are $3 up to 22 hours then $6 for all additional hours. \n"

.text

.global main
main:
	push {lr} 						/*push lr to the stack*/ 
	
	ldr r0, address_of_message1		/*Load into ro address_of_message1 as first parameter of printf*/
	bl printf 						/*Call printf*/
	
	pop {lr} 						/*pop lr to top of the stack*/ 
	bx lr 							/*Leave main*/

address_of_message1: .word message1
