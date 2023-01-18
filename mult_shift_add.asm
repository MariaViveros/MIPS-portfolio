# Maria Viveros
# Assignment 7
# This program does an integer multiplication using adds and shifts

.data
multiplicand: .word 0		# multiplicand input
multiplier:   .word 0			# multiplier input
inputMsg1:    .asciiz "Enter the multiplier number desired: "
inputMsg2:    .asciiz "Enter the multiplicand number desired: "
errorMsg:     .asciiz "The number must be between the range 0 - 32767. Please try again!\n"
outputMsg:    .asciiz "The product is: "
product:      .word 0

.text
.globl main

main:
	la $a0, inputMsg1		# Put the input message into $a0
	li $v0, 4			# Display input message (4: print_string)
	syscall
	
	li $v0, 5			# Input integer code (5: read_int)
	syscall 			# Get the input integer
	sw $v0, multiplier		# Store the input number
	lw $s1, multiplier		# Copy multiplier to $s1
	
	bltz $s1, error			# if the number is less than 0, go to error
	bgt $s1, 32767, error		# if the number is greater than 32767, go to error
	
	la $a0, inputMsg2		# Put the input message into $a0
	li $v0, 4			# Display input message (4: print_string)
	syscall
	
	li $v0, 5			# Input integer code (5: read_int)
	syscall 			# Get the input integer
	sw $v0, multiplicand		# Store the input number
	lw $s2, multiplicand		# Copy multiplicand to $s2
	
	bltz $s2, error			# if the number is less than 0, go to error
	bgt $s2, 32767, error		# if the number is greater than 32767, go to error
	
	lw $s3, product			# Copy product to $s3
	
	li $s4, 1 			# Apply a mask frot the extracting bit
	li $t1, 0 			# initiate a counter for loop
	
multiply:
	beq $t1, 31, exit		# if the counter equals 31, go to exit
	and $t0, $s1, $s4		# and for masking the multiplier and $s4
	sll $s4, $s4, 1			# shift by one the mask to the left 
	
	beq $t0, 0, multiply_inc	# if masking returned 0, go to multiply_inc
	add $s3, $s3, $s2		# add the multiplicand to the product
	
multiply_inc:
	sll $s2, $s2, 1			# shift by one to the left to keep adding
	addi $t1, $t1, 1		# add 1 to the counter
	j multiply			# Return to multiply
	
exit:
	li $v0, 4			# Display the output message
	la $a0, outputMsg		# Put the ouputMsg into $a0
	syscall 			# Get the message to the prompt
	
	li $v0, 1			# Display result's value (1: print_int)
	add $a0, $s3, $zero		# Copy result to $a0
	syscall 			# Get the answer in the prompt
		
	li $v0, 10			# Load exit value
	syscall				# Exit syscall
	
error:	
	la $a0, errorMsg		# Put the error message into $a0
	li $v0, 4			# Display error message (4: print_string)
	syscall				# Display the message into prompt
	
	j main 				# go to main program to start again