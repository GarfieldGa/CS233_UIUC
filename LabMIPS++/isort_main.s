.data
array:		.word 9 1 2 6 5 3 25 -4 -55 71 8
array_end:	# dummy label to get end address of array
array_length  = (array_end - array) / 4

.text

# print_array ##########################################################
#

print_array:
	sub	$sp, $sp, 12
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)

	move	$s0, $a0		# current element
	sub	$s1, $a1, 1		# length - 1
	sll	$s1, $s1, 2		# (length - 1) * 4
	add	$s1, $s0, $s1		# &array[length - 1]

pa_loop:
	beq	$s0, $s1, pa_last	# until second last element
	lw	$a0, 0($s0)		# array[i]
	jal	print_int_and_space
	add	$s0, $s0, 4		# next element
	j	pa_loop

pa_last:
	lw	$a0, 0($s0)		# last element
	jal	print_int_and_newline

	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	add	$sp, $sp, 12
	jr	$ra

# comparison functions for isort #######################################
#

ascending:
	slt	$t0, $a0, $a1
	neg	$t0, $t0
	sgt	$t1, $a0, $a1
	or	$v0, $t0, $t1
	jr	$ra

descending:
	sgt	$t0, $a0, $a1
	neg	$t0, $t0
	slt	$t1, $a0, $a1
	or	$v0, $t0, $t1
	jr	$ra

even_odd:
	and	$t0, $a0, 1
	and	$t1, $a1, 1
	beq	$t0, $t1, ascending	# x_odd == y_odd

	sll	$v0, $t0, 1		# x_odd * 2
	sub	$v0, $v0, 1		# x_odd * 2 - 1
	jr	$ra

# main #################################################################
#

main:
	sub	$sp, $sp, 4
	sw	$ra, 0($sp)

	la	$a0, array
	li	$a1, array_length
	la	$a2, ascending
	jal	isort
	la	$a0, array
	li	$a1, array_length
	jal	print_array

	la	$a0, array
	li	$a1, array_length
	la	$a2, descending
	jal	isort
	la	$a0, array
	li	$a1, array_length
	jal	print_array

	la	$a0, array
	li	$a1, array_length
	la	$a2, even_odd
	jal	isort
	la	$a0, array
	li	$a1, array_length
	jal	print_array

	lw	$ra, 0($sp)
	add	$sp, $sp, 4
	jr	$ra
