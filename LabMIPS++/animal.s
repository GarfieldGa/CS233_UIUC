.data
constructor_str:
	.asciiz "Inside animal constructor"

destructor_str:
	.asciiz "Inside animal destructor"

# you need to complete the rest of the file

animal_vtable:
	.word animal_destructor
	.word 0

.text
.globl animal_animal
animal_animal:
	sub $sp $sp 8
	sw $ra 0($sp)
	sw $a0 4($sp)
	la $t0 animal_vtable
	sw $t0 0($a0)
	sw $a1 4($a0)
	la $a0 constructor_str
	jal puts
	lw $ra 0($sp)
	lw $a0 4($sp)
  add $sp $sp 8
	jr $ra

.globl animal_destructor
animal_destructor:
	la $a0 destructor_str
	j puts

.globl animal_get_name
animal_get_name:
	lw $v0 4($a0)
	jr $ra
