.data
constructor_str:
	.asciiz "Inside pet constructor"

destructor_str:
	.asciiz "Inside pet destructor"

# you need to complete the rest of the file
pet_vtable:
	.word pet_destructor
	.word 0
	.word 0

.text
.globl pet_pet
pet_pet:
	sub $sp $sp 8
	sw $ra 0($sp)
	sw $a0 4($sp)
	jal animal_animal
	la $t0 pet_vtable
	sw $t0 0($a0)
	sw $a2 8($a0)
	la $a0 constructor_str
	jal puts
	lw $a0 4($sp)
	lw $ra 0($sp)
	add $sp $sp 8
	jr $ra

.globl pet_destructor
pet_destructor:
	sub $sp $sp 4
	sw $ra 0($sp)
	la $a0 destructor_str
	jal puts
	lw $ra 0($sp)
	add $sp $sp 4
	j animal_destructor

.globl pet_get_id
pet_get_id:
	lw $v0 8($a0)
	jr $ra
