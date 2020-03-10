.text

# short count_odd_nodes(TreeNode* head) {
#     // Base case
#     if (head == NULL) {
#         return 0;
#     }
#     // Recurse once for each child
# 	short count_left = count_odd_nodes(head->left);
#     short count_right = count_odd_nodes(head->right);
#     short count = count_left + count_right;
#     // Determine if this current node is odd
#     if (head->value%2 != 0) {
#         count += 1;
#     }
#     return count;
# }

.globl count_odd_nodes
count_odd_nodes:
	sub $sp $sp 12 #allocate stack pointer
	sw $s0 0($sp) # save count
	sw $a0 4($sp) # save head
	sw $ra 8($sp) # save ra
	li $s0 0 # count = 0
	beq $a0 $0 return #if head == NULL return 0
	lw $a0 0($a0) # load head->left
	jal count_odd_nodes #count_odd_nodes(head->left)
	add $s0 $s0 $v0 # count += count_left
	lw $a0 4($sp) # retrieve head
	lw $a0 4($a0) # load head->right
	jal count_odd_nodes #count_odd_nodes(head->right)
	add $s0 $s0 $v0 # count += count_right
	lw $a0 4($sp) #retrieve head
	lw $t0 8($a0) # load head->value
	andi $t0 $t0 1 #head->value%2
	beq $t0 $0 return # if head->value%2 == 0 jump return
	addi $s0 $s0 1 # count++

	return:
	move $v0 $s0 # move count to value
	lw $s0 0($sp) # retrieve count
	lw $ra 8($sp) #retrieve ra
	add $sp $sp 12 # retrieve stack pointer
	jr $ra
