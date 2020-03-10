// mips_decode: a decoder for MIPS arithmetic instructions
//
// alu_src2    (output) - should the 2nd ALU source be a register (0) or an immediate (1)
// rd_src      (output) - should the destination register be rd (0) or rt (1)
// writeenable (output) - should a new value be captured by the register file
// alu_op      (output) - control signal to be sent to the ALU
// except      (output) - set to 1 when the opcode/funct combination is unrecognized
// opcode      (input)  - the opcode field from the instruction
// funct       (input)  - the function field from the instruction
//

module mips_decode(alu_src2, rd_src, writeenable, alu_op, except, opcode, funct);
    output       alu_src2, rd_src, writeenable, except;
    output [2:0] alu_op;
    input  [5:0] opcode, funct;
    wire ADD, ADDI, SUB, AND, ANDI, OR, NOR, XOR, ORI, XORI;

    assign alu_src2 = opcode[0] | opcode[1] | opcode[2] | opcode[3] | opcode[4] | opcode[5];
    assign rd_src = alu_src2;

    assign ADD = (opcode == 6'h00) & (funct == `OP0_ADD);
    assign ADDI = opcode == `OP_ADDI;
    assign SUB = (opcode == 6'h00) & (funct == `OP0_SUB);
    assign AND = (opcode == 6'h00) & (funct == `OP0_AND);
    assign ANDI = opcode == `OP_ANDI;
    assign OR = (opcode == 6'h00) & (funct == `OP0_OR);
    assign NOR = (opcode == 6'h00) & (funct == `OP0_NOR);
    assign XOR = (opcode == 6'h00) & (funct == `OP0_XOR);
    assign ORI = opcode == `OP_ORI;
    assign XORI = opcode == `OP_XORI;

    assign alu_op = ADD | ADDI ? 2 :
            SUB ? 3 :
            AND | ANDI ? 4 :
            OR | ORI ? 5 :
            NOR ? 6 :
            XOR | XORI ? 7 :
            0;

    assign except = ~(ADD | ADDI | SUB | AND | ANDI | OR | ORI | NOR | XOR | XORI);
    assign writeenable = ~except;

endmodule // mips_decode
