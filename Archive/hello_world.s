# Author:       Eric Walkingshaw
# Date:         Jan 18, 2013
# Description:  A simple hello world program!
.data                   # add this stuff to the data segment
    hello:  .asciiz "Hello, world!"	# load the hello string into data memory
	
.text 				# now we’re in the text segment
main:				
	li $v0, 4		# set up print string syscall
	la $a0, hello 	# argument to print string
	syscall			# tell the OS to do the syscall
	li $v0, 10		# set up exit syscall
	syscall			# tell the OS to do the syscall