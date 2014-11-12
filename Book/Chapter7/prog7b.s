/*How to use syscall 3 to read from keyboard*/

.global _start
_start:
_read:
					@read syscall
	mov r7, #3 		@syscall number
	mov r0, #0 		@stdout is monitor
	mov r2, #5 		@read first 5 characters 
	ldr r1,=string 	@string placed at string:
	swi 0
	
_write:
					@write syscall
	mov r7, #4 		@syscall number
	mov r0, #1 		@stdout is monitor
	mov r2, #19 	@string is 19 chars long
	ldr r1,=string	@string located at start: 
	swi 0
	
_exit:
	@exit syscall
	mov r7, #1
	swi 0
	
.data
string:
.ascii "Hello World String\n"
