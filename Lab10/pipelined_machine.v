module pipelined_machine(clk, reset);
    input        clk, reset;

    wire [31:0]  PC;
    wire [31:2]  next_PC, PC_plus4, PC_target;
    wire [31:0]  inst;

    wire [31:0]  imm = {{ 16{inst[15]} }, inst[15:0] };  // sign-extended immediate
    wire [4:0]   rs = inst[25:21];
    wire [4:0]   rt = inst[20:16];
    wire [4:0]   rd = inst[15:11];
    wire [5:0]   opcode = inst[31:26];
    wire [5:0]   funct = inst[5:0];

    wire [4:0]   wr_regnum;
    wire [2:0]   ALUOp;

    wire         RegWrite, BEQ, ALUSrc, MemRead, MemWrite, MemToReg, RegDst;
    wire         PCSrc, zero;
    wire [31:0]  rd1_data, rd2_data, B_data, alu_out_data, load_data, wr_data;
    ///////////////////////////////////////////////////////////
    wire forward_A, forward_B, stall, MemRead_MW, RegWrite_MW, MemToReg_MW, MemWrite_MW, flush;
    wire [31:0] A_data, rd2_data_B, inst_IF, rd2_data_B_MW, alu_out_data_MW;
    wire [29:0] PC_plus4_DE;
    wire [4:0] wr_regnum_MW;


    // DO NOT comment out or rename this module
    // or the test bench will break
    register #(30, 30'h100000) PC_reg(PC[31:2], next_PC[31:2], clk, ~stall, reset);

    assign PC[1:0] = 2'b0;  // bottom bits hard coded to 00
    adder30 next_PC_adder(PC_plus4, PC[31:2], 30'h1);
    adder30 target_PC_adder(PC_target, PC_plus4_DE, imm[29:0]);
    mux2v #(30) branch_mux(next_PC, PC_plus4, PC_target, PCSrc);
    assign PCSrc = BEQ & zero;

    // DO NOT comment out or rename this module
    // or the test bench will break
    instruction_memory imem(inst_IF, PC[31:2]);

    mips_decode decode(ALUOp, RegWrite, BEQ, ALUSrc, MemRead, MemWrite, MemToReg, RegDst,
                      opcode, funct);

    // DO NOT comment out or rename this module
    // or the test bench will break
    regfile rf (rd1_data, rd2_data,
               rs, rt, wr_regnum_MW, wr_data,
               RegWrite_MW, clk, reset);

    mux2v #(32) imm_mux(B_data, rd2_data_B, imm, ALUSrc);
    alu32 alu(alu_out_data, zero, ALUOp, A_data, B_data);

    // DO NOT comment out or rename this module
    // or the test bench will break
    data_mem data_memory(load_data, alu_out_data_MW, rd2_data_B_MW, MemRead_MW, MemWrite_MW, clk, reset);

    mux2v #(32) wb_mux(wr_data, alu_out_data_MW, load_data, MemToReg_MW);
    mux2v #(5) rd_mux(wr_regnum, rt, rd, RegDst);

    ///////////////////////stage_register///////////////////////////
    register #(30) IF_reg1(PC_plus4_DE, PC_plus4, clk, ~stall, flush);
    register #(32) IF_reg2(inst, inst_IF, clk, ~stall, flush);

    register #(1) DE_reg_decode_1(RegWrite_MW, RegWrite, clk, 1'b1, reset);
    register #(1) DE_reg_decode_2(MemRead_MW, MemRead, clk, 1'b1, reset);
    register #(1) DE_reg_decode_6(MemToReg_MW, MemToReg, clk, 1'b1, reset);
    register #(1) DE_reg_decode_7(MemWrite_MW, MemWrite, clk, 1'b1, reset);

    register #(32) DE_reg3(alu_out_data_MW, alu_out_data, clk, 1'b1, reset);
    register #(32) DE_reg4(rd2_data_B_MW, rd2_data_B, clk, 1'b1, reset);
    register #(5) DE_reg5(wr_regnum_MW, wr_regnum, clk, 1'b1, reset);

    /////////////////////////forward_muxs//////////////////////////
    mux2v #(32) mux_A(A_data, rd1_data, alu_out_data_MW, forward_A);
    mux2v #(32) mux_B(rd2_data_B, rd2_data, alu_out_data_MW, forward_B);

    /////////////////////////forwarding_unit///////////////////////
    assign forward_A = (rs == wr_regnum_MW) & RegWrite_MW & ~(rs == 5'b0);
    assign forward_B = (rt == wr_regnum_MW) & RegWrite_MW & ~(rt == 5'b0);

    /////////////////////////hazard_unit//////////////////////////////////////
    assign stall = (((rt == wr_regnum_MW) & ~ALUSrc) | (rs == wr_regnum_MW)) & MemRead_MW;

    assign flush = PCSrc | reset;

endmodule // pipelined_machine
