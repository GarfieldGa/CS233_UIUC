.text

# int count_painted(int *wall, int width, int radius, int coord) {
# 	int row = (coord & 0xffff0000) >> 16;
# 	int col = coord & 0x0000ffff;
# 	int value = 0;
# 	for (int row_offset = -radius; row_offset <= radius; row_offset++) {
# 		int temp_row = row + row_offset;
# 		if (width <= temp_row || temp_row < 0) {
# 			continue;
# 		}
# 		for (int col_offset = -radius; col_offset <= radius; col_offset++) {
# 			int temp_col = col + col_offset;
# 			if (width <= temp_col || temp_col < 0) {
# 				continue;
# 			}
# 			value += wall[temp_row*width + temp_col];
# 		}
# 	}
# 	return value;
# }
#
# // a0: int *wall
# // a1: int width
# // a2: int radius
# // a3: int coord

.globl count_painted
count_painted:
	srl $t0 $a3 16 # row = (coord & oxffff0000) >> 16
	sll $t1 $a3 16 #col = (coord & 0x0000ffff) << 16
	srl $t1 $t1 16 #col = coord & 0x0000ffff
	li $v0 0 # value  = 0
	sub $t2 $zero $a2 #row_offset = -radius
	for_row_offset:
	  bgt $t2 $a2 return
	  add $t3 $t0 $t2 #temp_row = row + row_offset
	  ble $a1 $t3 add1_row #width <= temp_row
		blt $t3 $zero add1_row #temp_row < 0
		sub $t4 $zero $a2 #col_offset = -radius
		j for_col_offset
		j add1_row
	for_col_offset:
	  bgt $t4 $a2 add1_row
	  add $t5 $t1 $t4 #temp_col = col + col_offset
		ble $a1 $t5 add1_col #width <= temp_col
		blt $t5 $zero add1_col #temp_col < 0
		mul $t6 $t3 $a1 #temp_row * width
		add $t6 $t6 $t5 # index
		mul $t6 $t6 4 # index * 4
		add $t6 $t6 $a0 #address
		lw $t7 0($t6) #load wall[temp_row*width + temp_col]
		add $v0 $v0 $t7 #value += wall[temp_row*width + temp_col]
		j add1_col
	add1_col:
		addi $t4 $t4 1
		j for_col_offset
	add1_row:
	  addi $t2 $t2 1
		j for_row_offset
	return:
	jr	$ra

# int* get_heat_map(int *wall, int width, int radius) {
# 	int value = 0;
# 	for (int col = 0; col < width; col++) {
# 		for (int row = 0; row < width; row++) {
# 			int coord = (row << 16) | (col & 0x0000ffff);
# 			output_map[row*width + col] = count_painted(wall, width, radius, coord);
# 		}
# 	}
# 	return output_map;
# }
#
# // a0: int *wall
# // a1: int width
# // a2: int radius

.globl get_heat_map
get_heat_map:
	# Can access output_wall from p2.s
	li $v0 0 # value = 0
	sub $sp $sp 8 # allocate stack
	sw $ra 0($sp) # save ra
	li $s0 0 # col = 0

loop_col:
	bge $s0 $a1 end # col > width
	li $s1 0 # row = 0
	j loop_row

loop_row:
	bge $s1 $a1 add_col
	sll $t0 $s1 16 #row << 16
	and $t1 $s0 0x0000ffff #col & 0x0000ffff
	or $a3 $t0 $t1 #coord = (row << 16) | (col & 0x0000ffff)
	mul $t0 $a1 $s1 # row * width
	add $t0 $t0 $s0 # row*width + col
	mul $t0 $t0 4 #index addr
	la $t1 output_wall
	add $t0 $t0 $t1 # address
	sw $t0 4($sp)
	jal count_painted
	lw $t0 4($sp)
	sw $v0 0($t0) #output_map[row*width + col] = count_painted(wall, width, radius, coord)
	j add_row

add_col:
	add $s0 $s0 1 #col++
	j loop_col
add_row:
	add $s1 $s1 1 # row++
	j loop_row

end:
	la $v0 output_wall
	lw $ra 0($sp) # retrieve original address
	add $sp $sp 8
	jr	$ra
