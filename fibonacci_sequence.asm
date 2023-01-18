# Maria Viveros
# Assignment 4
# This pogram will compute the Fibonacci sequence using recursion.
# The number must be non-negative in order to work.

 .data
 inputMsg: 	.asciiz "Enter a number to compute the value of the nth element of the Fibonacci sequence."
 outputMsg1:	.asciiz "The "
 outputMsg2:	.asciiz "th value of the Fibonacci sequence is "
 invalidMsg:  	.asciiz "N must be greater than 0. Please try again" 
 N: 		.word 	1	# Number to get the element of the Fibonacci's sequence (Users input)
 result: 	.word 	1	# Nth value of the sequence
 
.text 
main: 	
		la 	$a0, inputMsg		# Put the input message into $a0
		li 	$v0, 4			# Display input message (4: print_string)
		syscall 			# Display the input prompt
		li 	$v0, 5			# Input integer code (5: read_int)
		syscall 			# Get the input integer
		sw 	$v0, N			# Store the input number
		
		lw 	$s1, N			# Copy N to $s1
		blez 	$s1, invalid		# if N is equal or less than 0, go to invalid		
		jal 	sequence		# if N is greater than 0, go to sequence
		sw 	$v0, result		# Store the result number
		
		li 	$v0, 4			# Display the output message
		la 	$a0, outputMsg1		# Put the ouputMsg1 into $a0
		syscall 			# Get the message to the prompt
		
		li 	$v0, 1			# Display N's value (1: print_int)
		lw 	$a0,N			# Copy N to $a0
		syscall 			# Get the value in the prompt
		
		li 	$v0, 4			# Display the output message
		la 	$a0, outputMsg2		# Put the ouputMsg2 into $a0
		syscall 			# Get the message to the prompt
		
		li 	$v0, 1			# Display result's value (1: print_int)
		lw 	$a0,result		# Copy result to $a0
		syscall 			# Get the answer in the prompt
		
		li 	$v0, 10			# Load exit value
		syscall 			# Exit syscall
		
sequence: 
		beqz 	$s1, zero   		# if N = 0 go to zero
		beq 	$s1, 1, one   		# if N = 1 go to one

		subu 	$sp, $sp, 4   		# Make space in the stack
		sw 	$ra, 0($sp)		# Store value from the $ra into the stack

		sub 	$s1, $s1, 1   		# Substract 1 from $s1, and store it in $s1
		jal 	sequence     		# Repeat the sequence loop to get f(n-1)
		add 	$s1, $s1, 1 		# Add 1 to $s1 to go back to main value

		lw 	$ra, 0($sp)   		# Restore return address from stack
		add 	$sp, $sp, 4		# Add 4 to  stack to get to next value in stack

		subu 	$sp, $sp, 4   		# Push return value to stack
		sw 	$v0, 0($sp)		# Store in stack

		subu 	$sp, $sp, 4   		# Store return address on stack
		sw 	$ra, 0($sp)		# Store value from $ra in stack

		sub 	$s1, $s1, 2   		# Substract 2 from $s1, and store it in $s1
		jal 	sequence    		# Repeat the sequence loop to get f(n-2)
		add 	$s1, $s1, 2		# Add 2 to $s1 to go back to main value

		lw 	$ra, 0($sp)   		# Restore return address from stack
		addu 	$sp, $sp, 4		# Restore stack

		lw 	$s7, 0($sp)   		# Pop return value from stack
		addu 	$sp, $sp, 4		# Restore stack

		add 	$v0, $v0, $s7 		# Add f(n - 2) + f(n-1)
		jr 	$ra 			# Return to main program
		
zero:
		li 	$v0, 0			# Set result $v0 = 0
		jr 	$ra			# Return to main program
one:
		li 	$v0, 1			# Set result $v0 = 1
		jr 	$ra			# Return to main program	
invalid: 
		la 	$a0, invalidMsg		# Put the invalidMsg into $v0
	  	li 	$v0, 4			# Display invalid message
	  	syscall				# Display the message into prompt	