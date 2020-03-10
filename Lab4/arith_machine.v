// arith_machine: execute a series of arithmetic instructions from an instruction cache
//
// except (output) - set to 1 when an unrecognized instruction is to be executed.
// clock  (input)  - the clock signal
// reset  (input)  - set to 1 to set all registers to zero, set to 0 for normal execution.

module arith_machine(except, clock, reset);
    output      except;
    input       clock, reset;

    wire [31:0] inst;
    wire [31:0] PC, nextPC;
    wire of1, zero1, neg1, of2, zero2, neg2;
    wire alu_src2, rd_src, writeenable;
    wire [2:0] alu_op;
    wire [4:0] rdaddr, rsaddr, rtaddr;
    wire [31:0] rsData, rtData, rdData, B_data, signExtended;

    // DO NOT comment out or rename this module
    // or the test bench will break
    register #(32) PC_reg(PC, nextPC, clock, 1'b1, reset);
    alu32 ALU1(nextPC, of1, zero1, neg1, PC, 32'h4, `ALU_ADD);

    // DO NOT comment out or rename this module
    // or the test bench will break
    instruction_memory im(inst, PC[31:2]);
    mips_decode decoder(alu_src2, rd_src, writeenable, alu_op, except, inst[31:26], inst[5:0]);
    mux2v #(5) m2(rdaddr, inst[15:11], inst[20:16], rd_src);
    assign rsaddr = inst[25:21];
    assign rtaddr = inst[20:16];

    // DO NOT comment out or rename this module
    // or the test bench will break
    regfile rf(rsData, rtData, rsaddr, rtaddr, rdaddr, rdData, writeenable, clock, reset);
    assign signExtended = {{16{inst[15]}}, inst[15:0]};
    mux2v #(32) m22(B_data, rtData, signExtended, alu_src2);
    alu32 ALU_OUT(rdData, of2, zero2, neg2, rsData, B_data, alu_op);

    /* add other modules */

endmodule // arith_machine
