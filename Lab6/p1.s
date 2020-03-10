.text

# // Finds the dot product between two different arrays of size n
# // Ignore integer overflow for the multiplication
# int paint_cost(unsigned int n, unsigned int* paint, unsigned int* cost) {
# 	int total = 0;
# 	for (int i = 0; i < n; i++) {
# 		total += paint[i] * cost[i];
# 	}
# 	return total;
# }

.globl paint_cost
paint_cost:
	li $t0 0 #total = 0
	li $t1 0 # i = 0
	li $t2 4
branch:
  bge	$t1 $a0 end	# if i >= n then end
	mul $t3 $t1 $t2 #i*4
	add $t4 $t3 $a1 #* pain[i]
	add $t5 $t3 $a2 #* cost[i]
	lw $t4 0($t4) # paint[i]
	lw $t5 0($t5) #cost[i]
  mul $t6 $t4 $t5 #tmp = paint[i] * cost[i]
	add $t0 $t0 $t6 #total += tmp
	addi $t1 $t1 1 #i++
	j branch #for_loop
end:
  move $v0 $t0
  jr	$ra
