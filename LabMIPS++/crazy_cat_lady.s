.data
constructor_str:
	.asciiz "Inside crazy_cat_lady constructor"

destructor_str:
	.asciiz "Inside crazy_cat_lady destructor"

# you need to complete the rest of the file
.text
.globl crazy_cat_lady_crazy_cat_lady
crazy_cat_lady_crazy_cat_lady:
  sub $sp $sp 8
  sw $ra 0($sp)
  sw $a0 4($sp)
  jal cat_cat
 	sw $a3 12($a0)
	la $a0 constructor_str
	jal puts
	lw $a0 4($sp)
	lw $ra 0($sp)
	add $sp $sp 8
	jr $ra

.globl crazy_cat_lady_destructor
crazy_cat_lady_destructor:
	sub $sp $sp 4
	sw $ra 0($sp)
	la $a0 destructor_str
	jal puts
	lw $ra 0($sp)
	add $sp $sp 4
	j cat_destructor

.globl crazy_cat_lady_get_name
crazy_cat_lady_get_name:
	lw $v0 12($a0)
	jr $ra

.globl crazy_cat_lady_pet_cat
crazy_cat_lady_pet_cat:
	lw $t0 0($a0)
	lw $t0 8($t0)
	jr $t0
