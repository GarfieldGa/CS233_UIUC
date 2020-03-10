module machine(clk, reset);
   input        clk, reset;

   wire [31:0]  PC, actual_PC;
   wire [31:2]  next_PC, PC_plus4, PC_target;
   wire [31:0]  inst;

   wire [31:0]  imm = {{ 16{inst[15]} }, inst[15:0] };  // sign-extended immediate
   wire [4:0]   rs = inst[25:21];
   wire [4:0]   rt = inst[20:16];
   wire [4:0]   rd = inst[15:11];

   wire [4:0]   wr_regnum;
   wire [2:0]   ALUOp;

   wire         RegWrite, BEQ, ALUSrc, MemRead, MemWrite, MemToReg, RegDst, MFC0, MTC0, ERET;
   wire         PCSrc, zero, negative;
   wire [31:0]  rd1_data, rd2_data, B_data, alu_out_data, load_data, wr_data;

   wire [31:0] rd_data_c0, cycle, wr_data_0;
   wire [29:0] EPC, no_interrupt_pc;
   wire TakenInterrupt, TimerInterrupt, TimerAddress, MemRead_op, MemWrite_op;

   assign MemRead_op = (~TimerAddress) & MemRead;
   assign MemWrite_op = (~TimerAddress) & MemWrite;

   register #(30, 30'h100000) PC_reg(PC[31:2], actual_PC[31:2], clk, /* enable */1'b1, reset);
   assign PC[1:0] = 2'b0;  // bottom bits hard coded to 00
   adder30 next_PC_adder(PC_plus4, PC[31:2], 30'h1);
   adder30 target_PC_adder(PC_target, PC_plus4, imm[29:0]);
   mux2v #(30) branch_mux(next_PC, PC_plus4, PC_target, PCSrc);
   assign PCSrc = BEQ & zero;

   instruction_memory imem (inst, PC[31:2]);

   mips_decode decode(ALUOp, RegWrite, BEQ, ALUSrc, MemRead, MemWrite, MemToReg, RegDst, MFC0, MTC0, ERET,
                      inst);

   regfile rf (rd1_data, rd2_data,
               rs, rt, wr_regnum, wr_data,
               RegWrite, clk, reset);

   mux2v #(32) imm_mux(B_data, rd2_data, imm, ALUSrc);
   alu32 alu(alu_out_data, zero, negative, ALUOp, rd1_data, B_data);

   data_mem data_memory(load_data, alu_out_data, rd2_data, MemRead_op, MemWrite_op, clk, reset);

   mux2v #(32) wb_mux(wr_data_0, alu_out_data, load_data, MemToReg);
   mux2v #(5) rd_mux(wr_regnum, rt, rd, RegDst);

   mux2v #(30) eret_mux(no_interrupt_pc, next_PC, EPC, ERET);
   mux2v #(32) pc_mux(actual_PC, {no_interrupt_pc, {2'b00}}, 32'h80000180, TakenInterrupt);
   mux2v #(32) wb_mux_real(wr_data, wr_data_0, rd_data_c0, MFC0);
   assign  load_data = cycle;

   timer tik_tok(TimerInterrupt, cycle, alu_out_data, rd2_data, address, MemRead, MemWrite, clk, reset);

   cp0 coprocessor(rd_data_c0, EPC, TakenInterrupt, rd2_data, rd, next_PC, MTC0, ERET, TimerInterrupt, clk, reset);


endmodule // machine
