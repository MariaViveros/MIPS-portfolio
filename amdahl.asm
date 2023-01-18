# Maria Viveros
# Assignment 11
# This program computes the value of Amdahl’s Law

.data 
inputMsg1: 	.asciiz "Number of processors (Positive integer): "
inputMsg2:	.asciiz "Percent of the program that must be run serially: "
errorMsg:	.asciiz "The number of processors must be greater than 0."
percentErrorMsg:.asciiz "The percentage number must be a decimal number\ngreater than 0 and less than 1"
outputMsg:	.asciiz "The maximum performance gain using Amdahl’s Law is: "
processors: 	.word 0
percentage:	.float 0
one:		.float 1
zero: 		.float 0

.text
.globl main

main:
	la 	$a0, inputMsg1		# Put the input message into $a0
	li 	$v0, 4			# Display input message (4: print_string)
	syscall
	
	li 	$v0, 5			# Input integer code (5: read_int)
	syscall 			# Get the input integer
	sw 	$v0, processors		# Store the input number
	lw 	$s1, processors		# Copy dividend to $s1
	
	blez 	$s1, error			# If the input is less or equal to 0, go to error
	
	la 	$a0, inputMsg2		# Put the input message into $a0
	li 	$v0, 4			# Display input message (4: print_string)
	syscall
	
	li 	$v0, 6			# Input float code (6: read_float)
	syscall 			# Get the input float
	s.s 	$f0, percentage		# Store the input number
	lwc1 	$f1, percentage		# Copy dividend to $s1
	
	lwc1 	$f2, one		# Load 1.0 into $f2
	
	lwc1 	$f9, zero		# Load 0 into $f9
	
	c.le.s 	$f1, $f9		# Is percentage less or equal to 0?
	bc1t 	percentageError		# If it is, go to percentageError
	
	c.lt.s 	$f1, $f2		# Is percentage less than 1?
	bc1f 	percentageError		# If it is, go to percentageError
	
	c.eq.s 	$f1, $f2		# Is percentage equal to 1?
	bc1t 	percentageError		# If it is, go to percentageError
	
	sub.s 	$f3, $f2, $f1		# Substract the percentage from one
	
	lwc1 	$f4, processors		# Load value from processors to $f4
	cvt.s.w $f5, $f4		# Convert the processors value to float
	
	div.s 	$f6, $f1, $f5		# Divide the percentage value by the processors
	
	add.s 	$f4, $f6, $f3		# Add the substract value plus the division value
	
	div.s 	$f1, $f2, $f4		# Divide one by the addition result
	
	jal 	printResult		# Go to printResult
	
exit: 
	li 	$v0, 10			# Load exit value
	syscall				# Exit syscall
	
percentageError: 	
	la 	$a0, percentErrorMsg	# Put the error message into $a0
	li 	$v0, 4			# Display error message (4: print_string)
	syscall				# Display the message into prompt
	
	jal 	exit 			# Exit the program
error:	
	la 	$a0, errorMsg		# Put the error message into $a0
	li 	$v0, 4			# Display error message (4: print_string)
	syscall				# Display the message into prompt
	
	jal 	exit 			# Exit the program	

printResult:	
	la 	$a0, outputMsg		# Put the output message into $a0
	li 	$v0, 4			# Display output message (4: print_string)
	syscall				# Display the message into prompt
	
	mov.s 	$f12, $f1		# Move the result to $f12
	li 	$v0, 2			# Print float in $f12
	syscall				# Get the result to the prompt
	
	jal 	main 			# Repeat the program	