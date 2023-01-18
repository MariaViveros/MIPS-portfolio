# Maria Viveros
# Assignment 12
# Program that accepts an integer input that represents a virtual address 
# and outputs the page number and offset for the given address in decimal.  

.data
inputMsg: 	.asciiz "Virtual address: "
outputMsg1:	.asciiz "The address "
outputMsg2:	.asciiz " is in:\nPage number = "
outputMsg3: 	.asciiz "\nOffset = "
address: 	.word 0
pageSize:	.word 4096

.text
.globl main

main:
	la 	$a0, inputMsg		# Put the input message into $a0
	li 	$v0, 4			# Display input message (4: print_string)
	syscall
	
	li 	$v0, 5			# Input integer code (5: read_int)
	syscall 			# Get the input integer
	sw 	$v0, address		# Store the input address
	lw 	$s1, address		# Copy the address to $s1
	
	lw	$s2, pageSize		# Load page size's value into $s2
	
	div 	$s1, $s2		# Divide the address by the page's size
	mfhi	$s4			# Store the remainder into $t1
	mflo	$s5			# Store the result into $t2, which is the page number	
	
exit:
	la 	$a0, outputMsg1		# Put the output message into $a0
	li 	$v0, 4			# Display output message (4: print_string)
	syscall				# Display the message into prompt

	li 	$v0, 1			# Display the address value
	move 	$a0, $s1		# Put the address value into $a0
	syscall				# Get the value to the prompt
	
	la 	$a0, outputMsg2		# Put the output message into $a0
	li 	$v0, 4			# Display output message (4: print_string)
	syscall				# Display the message into prompt

	li 	$v0, 1			# Display the page's number value
	move 	$a0, $s5		# Put the page's number value into $a0
	syscall				# Get the value to the prompt
	
	la 	$a0, outputMsg3		# Put the output message into $a0
	li 	$v0, 4			# Display output message (4: print_string)
	syscall				# Display the message into prompt
	
	li 	$v0, 1			# Display the offset's value
	move 	$a0, $s4		# Put the offset's value into $a0
	syscall				# Get the value to the prompt

	li 	$v0, 10			# Load exit value
	syscall				# Exit syscall