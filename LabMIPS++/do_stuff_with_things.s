.data
sam_str:
	.asciiz "Sam"

a256_str:
	.asciiz "A256"

tom_str:
	.asciiz "Tom"

c65536_str:
	.asciiz "C65536"

eleanor_str:
	.asciiz "Eleanor"

# you need to complete the rest of the file

.text
.globl do_stuff_with_things
do_stuff_with_things:
	sub $sp $sp 32
	sw $ra 0($sp)
	la $a0 4($sp)
	la $a1 sam_str
	la $a2 a256_str
  jal dog_dog
	la $a0 4($sp)
	jal print_pet_info
	la $a0 16($sp)
	la $a1 tom_str
	la $a2 c65536_str
	la $a3 eleanor_str
	jal crazy_cat_lady_crazy_cat_lady
	la $a0 16($sp)
	jal crazy_cat_lady_pet_cat
	lw $a0 16($sp)
	jal crazy_cat_lady_destructor
	lw $a0 4($sp)
	jal dog_destructor
	lw $ra 0($sp)
	add $sp $sp 32
	jr $ra
