// full_machine: execute a series of MIPS instructions from an instruction cache
//
// except (output) - set to 1 when an unrecognized instruction is to be executed.
// clock   (input) - the clock signal
// reset   (input) - set to 1 to set all registers to zero, set to 0 for normal execution.

module full_machine(except, clock, reset);
    output      except;
    input       clock, reset;

    wire [31:0] inst;
    wire [31:0] PC, nextPC, normal_PC;
    wire of1, zero1, neg1, of2, zero2, neg2;
    wire alu_src2, rd_src, writeenable;
    wire mem_read, word_we, byte_we, byte_load;
    wire slt, lui, addm;
    wire [1:0] control_type;
    wire [2:0] alu_op;
    wire [4:0] rdaddr, rsaddr, rtaddr;
    wire [31:0] rsData, rtData, rdData, B_data, signExtended;

    // DO NOT comment out or rename this module
    // or the test bench will break
    register #(32) PC_reg(PC, nextPC, clock, 1'b1, reset);
    alu32 ALU_PC(normal_PC, of1, zero1, neg1, PC, 32'h4, `ALU_ADD);

    // DO NOT comment out or rename this module
    // or the test bench will break
    instruction_memory im(inst, PC[31:2]);
    mips_decode decoder(alu_op, writeenable, rd_src, alu_src2, except, control_type,
                       mem_read, word_we, byte_we, byte_load, slt, lui, addm,
                       inst[31:26], inst[5:0], zero2);

    mux2v #(5) m2(rdaddr, inst[15:11], inst[20:16], rd_src);
    assign rsaddr = inst[25:21];
    assign rtaddr = inst[20:16];

    // DO NOT comment out or rename this module
    // or the test bench will break
    wire[31:0] alu_out;
    regfile rf(rsData, rtData, rsaddr, rtaddr, rdaddr, rdData, writeenable, clock, reset);
    assign signExtended = {{16{inst[15]}}, inst[15:0]};
    mux2v #(32) m22(B_data, rtData, signExtended, alu_src2);
    alu32 ALU_OUT(alu_out, of2, zero2, neg2, rsData, B_data, alu_op);

    /* add other modules */
    wire[31:0] loaded, slt_selected, data, lui_selected;
    wire[31:0] data_out;
    wire[7:0] byte_selected;
    wire ze = 1'b0;
    data_mem Memory(data_out, alu_out, rtData, word_we, byte_we, clock, reset);
    mux4v #(8) byte_mux(byte_selected, data_out[7:0], data_out[15:8], data_out[23:16], data_out[31:24], alu_out[1:0]);
    mux2v #(32) slt_mux(slt_selected, alu_out, {{31{ze}}, neg2}, slt);
    mux2v #(32) mem_read_mux(data, slt_selected, {{24{ze}}, byte_selected}, mem_read);
    mux2v #(32) byte_load_mux(loaded, data_out, {{24{ze}}, byte_selected}, byte_load);
    mux2v #(32) lui_mux(lui_selected, data, {inst[15:0], {16{ze}}}, lui);

    wire[31:0] branch_offset = {signExtended[29:0], {2{ze}}};
    wire of3, zero3, neg3, of4, zero4, neg4;
    wire[31:0] branch, addm_out;
    alu32 branch_alu(branch, of3, zero3, neg3, normal_PC, branch_offset, `ALU_ADD);
    mux4v mux_PC(nextPC, normal_PC, branch, {PC[31:28], inst[25:0], {2{ze}}}, rsData, control_type);

    alu32 Alu_addm(addm_out, of4, zero4, neg4, rtData, {{24{ze}}, byte_selected}, `ALU_ADD);
    mux2v addm_mux(rdData, lui_selected, addm_out, addm);

endmodule // full_machine
