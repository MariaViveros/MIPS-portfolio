# Maria Viveros
# Assignment 8
# This program does an integer divide using subtracts

.data
dividend: .word 0		# dividend input
divisor:   .word 0		# divisor input
inputMsg1:    .asciiz "Enter the dividend number desired: "
inputMsg2:    .asciiz "Enter the divisor number desired: "
errorMsg:     .asciiz "The divisor can not be 0. Please try again!\n"
outputMsg1:   .asciiz "For "
outputMsg2:   .asciiz " divided by "
outputMsg3:   .asciiz ", the quotient is "
outputMsg4:   .asciiz " and the reminder is "
quotient:     .word 0
reminder:     .word 0

.text
.globl main

main:
	la $a0, inputMsg1		# Put the input message into $a0
	li $v0, 4			# Display input message (4: print_string)
	syscall
	
	li $v0, 5			# Input integer code (5: read_int)
	syscall 			# Get the input integer
	sw $v0, dividend		# Store the input number
	lw $s1, dividend		# Copy dividend to $s1
	
	la $a0, inputMsg2		# Put the input message into $a0
	li $v0, 4			# Display input message (4: print_string)
	syscall
	
	li $v0, 5			# Input integer code (5: read_int)
	syscall 			# Get the input integer
	sw $v0, divisor			# Store the input number
	lw $s2, divisor			# Copy divisor to $s2
	
	beqz $s2, error			# if the divisor is equal 0, go to error
	
	mult $s1, $s2			# Multiply the dividend by the divisor
	mflo $s5			# Store the product into $s5
	bltz $s5, negative		# if the product is less than zero, go to negative
	li $s5, 1			# if the product is greater than 0, put the sign value to 1 to be positive
	
absolute:
	li $t1, 0 			# initiate a counter for quotient

	abs $s3, $s1			# Get the absolute value from the dividend, and store it in $s4
	abs $s4, $s2			# Get the absolute value from the divisor, and store it in $s4
	
division:
	
	bge $s3, $s4, loop		# if the dividend is greater or equal to divisor, go to loop
	
	mult $s5, $t1			# multiply the sign by the quotient
	mflo $t2			# store the product in $t2
	
	j exit				# Go to exit
	
loop:
	sub $s3, $s3, $s4		# Subtract the dividend from the divisor
	addi $t1, $t1, 1		# Add 1 to the quotient counter
	j division			# Return to division
	
exit:
	li $v0, 4			# Display the output message
	la $a0, outputMsg1		# Put the ouputMsg into $a0
	syscall 			# Get the message to the prompt
	
	li $v0, 1			# Display the dividend value
	move $a0, $s1			# Put the dividend value into $a0
	syscall				# Get the value to the prompt
	
	li $v0, 4			# Display the output message
	la $a0, outputMsg2		# Put the ouputMsg into $a0
	syscall 			# Get the message to the prompt
	
	li $v0, 1			# Display the divisor value
	move $a0, $s2			# Put the divisor value into $a0
	syscall				# Get the value to the prompt
	
	li $v0, 4			# Display the output message
	la $a0, outputMsg3		# Put the ouputMsg into $a0
	syscall 			# Get the message to the prompt
	
	li $v0, 1			# Display the quotient value
	move $a0, $t2			# Put the reminder quotient into $a0
	syscall				# Get the value to the prompt
	
	li $v0, 4			# Display the output message
	la $a0, outputMsg4		# Put the ouputMsg into $a0
	syscall 			# Get the message to the prompt
	
	li $v0, 1			# Display the reminder value
	move $a0, $s3			# Put the reminder value into $a0
	syscall				# Get the value to the prompt
		
	li $v0, 10			# Load exit value
	syscall				# Exit syscall
	
error:	
	la $a0, errorMsg		# Put the error message into $a0
	li $v0, 4			# Display error message (4: print_string)
	syscall				# Display the message into prompt
	
	j main 				# go to main program to start again

negative:
	li $s5, -1			# change the sign value to -1 to be negative
	j absolute			# go to absolute to keep running the program