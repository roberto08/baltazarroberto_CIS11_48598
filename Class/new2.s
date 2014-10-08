/* -- printf01.s */
.data
 
/* First message */
.balign 4
message1: .asciz "Hey, type a number: "
 
/* Second message */
.balign 4
message2: .asciz "I read the number %d\n"
 
/* Format pattern for scanf */
.balign 4
scan_pattern : .asciz "%d"
 
/* Where scanf will store the number read */
.balign 4
number_read: .word 0
 
.balign 4
return: .word 0
 
.text
 
.global main
main:
    ldr r1, address_of_return        /* r1 ? &address_of_return */
    str lr, [r1]                     /* *r1 ? lr */
 
    ldr r0, address_of_message1      /* r0 ? &message1 */
