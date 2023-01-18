# Maria Viveros
# Assignment 6
# This program will demonstrate that the associative law fails in addition
# for floating point numbers (only demonstrates single precision)

.data
numberA: .float 1.0e+30
numberB: .float -1.0e+30
numberC: .float 3.0
outputMsg1: .asciiz "Using a = 1.0e+30, b = -1.0e+30, and c = 3.0\na + (b + c) = "
outputMsg2: .asciiz "\n(a + b) + c = "

.text
	lwc1 $f1, numberA	# Put  the number A into the register $f1
	lwc1 $f2, numberB	# Put  the number B into the register $f2
	lwc1 $f3, numberC	# Put  the number C into the register $f3
	
	add.s $f5, $f2, $f3	# b + c, result in $f5
	add.s $f6, $f1, $f5	# a + (b + c), result in $f6
	
	add.s $f8, $f1, $f2	# a + b, result in $f8
	add.s $f10, $f8, $f3	# (a + b) + c, result in $f10
	
	li $v0, 4		# Display the output message
	la $a0, outputMsg1	# Put the ouputValue into $a0
	syscall 		# Get the message to the prompt
	
	mov.s $f12, $f6		# Move $f6 to $f12
	li $v0, 2		# Print float in $f12
	syscall			# Get the result to the prompt
	
	li $v0, 4		# Display the output message
	la $a0, outputMsg2	# Put the ouputValue into $a0
	syscall 		# Get the message to the prompt
	
	mov.s $f12, $f10	# Move $f10 to $f12
	li $v0, 2		# Print float in $f12
	syscall			# Get the result to the prompt
	
	li $v0, 10		# Load exit value
	syscall 		# Exit syscall