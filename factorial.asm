# Maria Viveros
# Assignment 3
# This pogram will calculate the factorial of a number.
# The number must be non-negative in order to work.

 .data
 inputValue: 	.asciiz "Enter a number (non-negative) to calculate its factorial"
 outputValue:	.asciiz "The factorial of the number is "
 undefinedMsg:  .asciiz "N! undefined for values less than 0" 
 N: 		.word 	0	# Number to calculate its factorial (Users input)
 fact: 		.word 	1	# Factorial
 
.text 
		la $a0, inputValue	# Put the input value into $a0
		li $v0, 4		# Display input message (4: print_string)
		syscall 		# Display the input prompt
		li $v0, 5		# Input integer code (5: read_int)
		syscall 		# Get the input integer
		sw $v0, N		# Store the input number
		
		lw $s1, N		# Copy N to $s1
		bltz $s1, undefined  	# if $s1 is less than 0, go to undefined
		jal factorial		# if $s1 is equal or greater tann 0, go to factorial
		sw $v0, fact		# Store the result number
		
		li $v0, 4		# Display the output message
		la $a0, outputValue	# Put the ouputValue into $a0
		syscall 		# Get the message to the prompt
		
		li $v0, 1		# Display answer's value (1: print_int)
		lw $a0, fact		# Copy fact to $a0
		syscall 		# Get the answer in the prompt
		
		li $v0, 10		# Load exit value
		syscall 		# Exit syscall
		
factorial:	
		subu $sp, $sp, 8	# Enough space in the stack for 2 values
		sw $ra, ($sp)		# Store value from the $ra into the stack
		sw $s0, 4($sp)		# Store $s0 in stack
		
		li $v0, 1		# Return 1
		beq $s1, $zero, endFactorial # When $s1 is equal to 0, go to endFactorial
		
		move $s0, $s1		# Copy value from $s0 to $s1
		sub $s1, $s1, 1		# Substract 1 from $s1
		jal factorial		# Repeat the factorial loop
		
		mul $v0, $s0, $v0	# Multiply $v0 times $s0, and store it into $v0
		
		endFactorial:		# Load values from the stack
				lw $ra, ($sp)	 # Restoring value of $ra from the stack
				lw $s0, 4($sp)	 # Value of the stack back to $s00
				addu $sp, $sp, 8 # Restore stack	
				jr $ra 		 # Go back to main program 
				
undefined: 
		la $a0, undefinedMsg	# Put the undefinedMsg into $v0
	  	li $v0, 4		# Display undefined message
	  	syscall			# Display the message into prompt
	  	
	  	