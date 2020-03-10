.text

# bool rule1(unsigned short* board) {
#   bool changed = false;
#   for (int y = 0 ; y < GRIDSIZE ; y++) {
#     for (int x = 0 ; x < GRIDSIZE ; x++) {
#       unsigned value = board[y*GRIDSIZE + x];
#       if (has_single_bit_set(value)) {
#         for (int k = 0 ; k < GRIDSIZE ; k++) {
#           // eliminate from row
#           if (k != x) {
#             if (board[y*GRIDSIZE + k] & value) {
#               board[y*GRIDSIZE + k] &= ~value;
#               changed = true;
#             }
#           }
#           // eliminate from column
#           if (k != y) {
#             if (board[k*GRIDSIZE + x] & value) {
#               board[k*GRIDSIZE + x] &= ~value;
#               changed = true;
#             }
#           }
#         }
#       }
#     }
#   }
#   return changed;
# }
#a0: board

.globl rule1
rule1:
sub $sp $sp 28
sw $ra 0($sp) # $ra
sw $s0 4($sp) # changed
sw $s1 8($sp) # y
sw $s2 12($sp) # x
sw $s3 16($sp) # k
sw $a0 20($sp) # board
sw $s4 24($sp) # value
  li $s1 0
  loop_y:
  bge $s1 GRIDSIZE return_rule1 # for (int y = 0 ; y < GRIDSIZE ; y++)
    li $s2 0
    loop_x:
    bge $s2 GRIDSIZE addy # for (int x = 0 ; x < GRIDSIZE ; x++)
    mul $t0 $s1 GRIDSIZE
    add $t0 $t0 $s2
    mul $t0 $t0 2
    lw $a0 20($sp)
    add $t0 $t0 $a0
    lhu $s4 0($t0) # unsigned value = board[y*GRIDSIZE + x]
    move $a0 $s4
    jal has_single_bit_set
      li $s3 0
    bne $v0 $0 loop_k # if (has_single_bit_set(value))
    j addx

      loop_k:
      bge $s3 GRIDSIZE addx
      bne $s3 $s2 eliminate_row
      row_back:
      bne $s3 $s1 eliminate_col
      j addk

        eliminate_row:
        mul $t0 $s1 GRIDSIZE
        add $t0 $t0 $s3
        mul $t0 $t0 2
        lw $a0 20($sp)
        add $t0 $t0 $a0
        lhu $t1 0($t0)
        and $t2 $t1 $s4
        beq $t2 $0 row_back # if (board[k*GRIDSIZE + x] & value)
        not $t2 $s4
        and $t2 $t1 $t2
        sh $t2 0($t0) # board[y*GRIDSIZE + k] &= ~value
        li $s0 1 # changed = true
        j row_back

        eliminate_col:
        mul $t0 $s3 GRIDSIZE
        add $t0 $t0 $s2
        mul $t0 $t0 2
        lw $a0 20($sp)
        add $t0 $t0 $a0
        lhu $t1 0($t0)
        and $t2 $t1 $s4
        beq $t2 $0 addk # if (board[k*GRIDSIZE + x] & value)
        not $t2 $s4
        and $t2 $t1 $t2
        sh $t2 0($t0) # board[k*GRIDSIZE + x] &= ~value
        li $s0 1
        j addk

        addk:
        addi $s3 1
        j loop_k

      addx:
      addi $s2 1
      j loop_x

    addy:
    addi $s1 1
    j loop_y

return_rule1:
move $v0 $s0
lw $ra 0($sp)
lw $s0 4($sp)
lw $s1 8($sp)
lw $s2 12($sp)
lw $s3 16($sp)
lw $a0 20($sp)
lw $s4 24($sp)
add $sp $sp 28
jr $ra



# bool solve(unsigned short *current_board, unsigned row, unsigned col, Puzzle* puzzle) {
#     if (row >= GRIDSIZE || col >= GRIDSIZE) {
#         bool done = board_done(current_board, puzzle);
#         if (done) {
#             copy_board(current_board, puzzle->board);
#         }

#         return done;
#     }
#     current_board = increment_heap(current_board);

#     bool changed;
#     do {
#         changed = rule1(current_board);
#         changed |= rule2(current_board);
#     } while (changed);

#     short possibles = current_board[row*GRIDSIZE + col];
#     for(char number = 0; number < GRIDSIZE; ++number) {
#         // Remember & is a bitwise operator
#         if ((1 << number) & possibles) {
#             current_board[row*GRIDSIZE + col] = 1 << number;
#             unsigned next_row = ((col == GRIDSIZE-1) ? row + 1 : row);
#             if (solve(current_board, next_row, (col + 1) % GRIDSIZE, puzzle)) {
#                 return true;
#             }
#             current_board[row*GRIDSIZE + col] = possibles;
#         }
#     }
#     return false;
# }

.globl solve
solve:
sub $sp $sp 40
sw $ra 0($sp) # $ra
sw $a0 4($sp) # current_board
sw $a1 8($sp) # row
sw $a2 12($sp) # col
sw $s0 16($sp) # done
sw $s1 20($sp) # changed
sw $s2 24($sp) # possibles
sw $s3 28($sp) # number
sw $s4 32($sp) # next_row
sw $a3 36($sp) # puzzle
bge $a1 GRIDSIZE function_body1
bge $a2 GRIDSIZE function_body1 # if (row >= GRIDSIZE || col >= GRIDSIZE)
jal increment_heap
move $a0 $v0 # current_board = increment_heap(current_board);
jal rule1
move $s1 $v0 # changed = rule1(current_board)
jal rule2
or $s1 $s1 $v0 # changed |= rule2(current_board)
while_back:
bne $s1 $0 while # while(changed)
mul $t0 $a1 GRIDSIZE
add $t0 $t0 $a2
mul $t0 $t0 2
add $t0 $t0 $a0
lhu $s2 0($t0) # short possibles = current_board[row*GRIDSIZE + col]
  li $s3 0
  for_loop:
  bge $s3 GRIDSIZE return_false # for(char number = 0; number < GRIDSIZE; ++number)
  sll $t1 $s3 1
  and $t2 $t1 $s2
  beq $t2 $0 add_char # if ((1 << number) & possibles)
  sh $t1 0($t0) # current_board[row*GRIDSIZE + col] = 1 << number
  addi $t3 $a2 1
  bne $t3 GRIDSIZE trinary_false
  addi $t3 $a1 1
  move $s4 $t3 # unsigned next_row = ((col == GRIDSIZE-1) ? row + 1 : row)
  move $a1 $s4
  addi $t3 $a2 1
  rem $t3 $t3 GRIDSIZE
  move $a2 $t3
  jal solve # if (solve(current_board, next_row, (col + 1) % GRIDSIZE, puzzle))
  bne $v0 $0 return_true
  mul $t3 $a1 GRIDSIZE
  add $t3 $t3 $a2
  mul $t3 $t3 2
  add $t3 $t3 $a0
  sh $s2 0($t3) # current_board[row*GRIDSIZE + col] = possibles
  j add_char

    return_true:
    li $v0 1
    lw $ra 0($sp)
    lw $a0 4($sp)
    lw $a1 8($sp)
    lw $a2 12($sp)
    lw $s1 20($sp)
    lw $s2 24($sp)
    lw $s3 28($sp)
    lw $s4 32($sp)
    lw $a3 36($sp)
    add $sp $sp 40
    jr $ra

    trinary_false:
    move $s4 $a1

    add_char:
    addi $s3 1
    j for_loop

  while:
  jal rule1
  move $s1 $v0 # changed = rule1(current_board)
  jal rule2
  or $s1 $s1 $v0 # changed |= rule2(current_board)
  j while_back

  function_body1:
  move $a1 $a3
  jal board_done # board_done(current_board, puzzle)
  move $s0 $v0
  beq $s0 $0 return_done
  lw $a1 0($a3) # puzzle->board
  jal copy_board # copy_board(current_board, puzzle->board)
  lw $s0 16($sp)
    return_done:
    move $v0 $s0
    lw $ra 0($sp)
    lw $a0 4($sp)
    lw $a1 8($sp)
    lw $a2 12($sp)
    lw $s1 20($sp)
    lw $s2 24($sp)
    lw $s3 28($sp)
    lw $s4 32($sp)
    lw $a3 36($sp)
    add $sp $sp 40
    jr $ra

  return_false:
  li $v0 0
  lw $ra 0($sp)
  lw $a0 4($sp)
  lw $a1 8($sp)
  lw $a2 12($sp)
  lw $s1 20($sp)
  lw $s2 24($sp)
  lw $s3 28($sp)
  lw $s4 32($sp)
  lw $a3 36($sp)
  add $sp $sp 40
	jr $ra
