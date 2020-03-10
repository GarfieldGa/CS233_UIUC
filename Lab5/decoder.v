// mips_decode: a decoder for MIPS arithmetic instructions
//
// alu_op       (output) - control signal to be sent to the ALU
// writeenable  (output) - should a new value be captured by the register file
// rd_src       (output) - should the destination register be rd (0) or rt (1)
// alu_src2     (output) - should the 2nd ALU source be a register (0) or an immediate (1)
// except       (output) - set to 1 when we don't recognize an opdcode & funct combination
// control_type (output) - 00 = fallthrough, 01 = branch_target, 10 = jump_target, 11 = jump_register
// mem_read     (output) - the register value written is coming from the memory
// word_we      (output) - we're writing a word's worth of data
// byte_we      (output) - we're only writing a byte's worth of data
// byte_load    (output) - we're doing a byte load
// slt          (output) - the instruction is an slt
// lui          (output) - the instruction is a lui
// addm         (output) - the instruction is an addm
// opcode        (input) - the opcode field from the instruction
// funct         (input) - the function field from the instruction
// zero          (input) - from the ALU
//

module mips_decode(alu_op, writeenable, rd_src, alu_src2, except, control_type,
                   mem_read, word_we, byte_we, byte_load, slt, lui, addm,
                   opcode, funct, zero);
    output [2:0] alu_op;
    output       writeenable, rd_src, alu_src2, except;
    output [1:0] control_type;
    output       mem_read, word_we, byte_we, byte_load, slt, lui, addm;
    input  [5:0] opcode, funct;
    input        zero;
    wire ADD, ADDI, SUB, AND, ANDI, OR, NOR, XOR, ORI, XORI, BNE, BEQ, J, JR, LUI, SLT, LW, LBU, SW, SB, ADDM;

    assign alu_src2 = (opcode[0] | opcode[1] | opcode[2] | opcode[3] | opcode[4] | opcode[5]) & ~BNE & ~BEQ;
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

    assign BEQ = opcode == `OP_BEQ;
    assign BNE = opcode == `OP_BNE;
    assign J = opcode == `OP_J;
    assign JR = (opcode == 6'h00) & (funct == `OP0_JR);
    assign LUI = opcode == `OP_LUI;
    assign SLT = (opcode == 6'h00) & (funct == `OP0_SLT);
    assign LW = opcode == `OP_LW;
    assign LBU = opcode == `OP_LBU;
    assign SW = opcode == `OP_SW;
    assign SB = opcode == `OP_SB;
    assign ADDM = (opcode == 6'h00) & (funct == `OP0_ADDM);

    assign lui = LUI;
    assign slt = SLT;
    assign mem_read = LW | LBU;
    assign byte_load = LBU;
    assign word_we = SW;
    assign byte_we = SB;
    assign addm = ADDM;

    assign control_type[0] = (BNE & ~zero) | (BEQ & zero) | JR;
    assign control_type[1] = J | JR;

    assign alu_op = ADD | ADDI | ADDM ? 2 :
            SUB | BNE | BEQ | SLT ? 3 :
            AND | ANDI ? 4 :
            OR | ORI ? 5 :
            NOR ? 6 :
            XOR | XORI ? 7 :
            0;

    assign except = ~(ADD | ADDI | SUB | AND | ANDI | OR | ORI | NOR | XOR | XORI | BNE | BEQ | J | JR | LUI | SLT | LW | LBU | SW | SB | ADDM);
    assign writeenable = ~except & ~BNE & ~BEQ & ~J & ~JR & ~SW & ~SB;
endmodule // mips_decode
