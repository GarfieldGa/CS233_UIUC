.data
constructor_str:
	.asciiz "Inside dog constructor"

destructor_str:
	.asciiz "Inside dog destructor"

woof_str:
	.asciiz "Woof"

wag_str:
	.asciiz "Wag"

# you need to complete the rest of the file
dog_vtable:
	.word dog_destructor
	.word dog_speak
	.word dog_express_happiness

.text
.globl dog_dog
dog_dog:
	sub $sp $sp 8
	sw $ra 0($sp)
	sw $a0 4($sp)
	jal pet_pet
	la $t0 dog_vtable
	sw $t0 0($a0)
	la $a0 constructor_str
	jal puts
	lw $a0 4($sp)
	lw $ra 0($sp)
	add $sp $sp 8
	jr $ra

.globl dog_destructor
dog_destructor:
	sub $sp $sp 4
	sw $ra 0($sp)
	la $a0 destructor_str
	jal puts
	lw $ra 0($sp)
	add $sp $sp 4
	j pet_destructor

.globl dog_speak
dog_speak:
	la $a0 woof_str
	j puts

.globl dog_express_happiness
dog_express_happiness:
	la $a0 wag_str
	j puts
