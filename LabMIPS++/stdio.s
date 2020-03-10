# syscall constants
PRINT_INT  = 1
PRINT_STR  = 4
PRINT_CHAR = 11

.text
.globl print_int_and_space
print_int_and_space:
	li	$v0, PRINT_INT
	syscall
	# fall through to print_space

print_space:
	li	$v0, PRINT_CHAR
	li	$a0, ' '
	syscall
	jr	$ra

.globl print_int_and_newline
print_int_and_newline:
	li	$v0, PRINT_INT
	syscall
	j	print_newline

.globl puts
puts:
	li	$v0, PRINT_STR
	syscall
	# fall through to print_newline

print_newline:
	li	$v0, PRINT_CHAR
	li	$a0, '\n'
	syscall
	jr	$ra
