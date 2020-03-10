.text
.globl print_pet_info
print_pet_info:
# you need to complete the rest of the file
  sub $sp $sp 8
	sw $ra 0($sp)
	sw $a0 4($sp)
	jal animal_get_name
	move $a0 $v0
	jal puts
	lw $a0 4($sp)
	jal pet_get_id
	move $a0 $v0
	jal puts
	lw $a0 4($sp)
	lw $t0 0($a0)
	lw $t0 4($t0)
	jalr $t0
	lw $a0 4($sp)
	lw $t0 0($a0)
	lw $t0 8($t0)
	jalr $t0
	lw $a0 4($sp)
	lw $ra 0($sp)
	add $sp $sp 8
	jr	$ra
