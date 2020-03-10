## typedef int (*compare_fn)(int, int);
##
## void isort(int * array, int length, compare_fn compare) {
##     for (int i = 1; i < length; ++i) {
##         int curr = array[i];
##         int j;
##         for (j = i; j > 0 && compare(curr, array[j - 1]) < 0; --j) {
##             array[j] = array[j - 1];
##         }
##         array[j] = curr;
##     }
## }

.text
.globl isort
isort:	# $a0 = array (pointer), $a1 = length, $a2 = function pointer
# you need to complete the rest of the file
sub $sp $sp 28
sw $ra 0($sp)
sw $a0 4($sp)
sw $a1 8($sp)
sw $s0 12($sp)
sw $s1 16($sp)
sw $s3 20($sp)
sw $s4 24($sp)
move $s4 $a2
li $s0 1
loop:
bge $s0 $a1 end
mul $t0 $s0 4
add $t0 $t0 $a0
lw $s3 0($t0)
move $s1 $s0
inner_loop:
ble $s1 0 inner_end
move $a0 $s3
sub $t0 $s1 1
mul $t0 $t0 4
lw $t1 4($sp)
add $t0 $t1 $t0
lw $a1 0($t0)
jalr $s4
bge $v0 0 inner_end
lw $a0 4($sp)
mul $t0 $s1 4
add $t0 $a0 $t0
sub $t1 $s1 1
mul $t1 $t1 4
add $t1 $t1 $a0
lw $t1 0($t1)
sw $t1 0($t0)
sub $s1 $s1 1
j inner_loop
inner_end:
lw $a0 4($sp)
mul $t0 $s1 4
add $t0 $a0 $t0
sw $s3 0($t0)
add $s0 $s0 1
lw $a1 8($sp)
j loop
end:
lw $ra 0($sp)
lw $a0 4($sp)
lw $a1 8($sp)
lw $s0 12($sp)
lw $s1 16($sp)
lw $s3 20($sp)
lw $s4 24($sp)
add $sp $sp 28
jr $ra
