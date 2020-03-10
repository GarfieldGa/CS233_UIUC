`define STATUS_REGISTER 5'd12
`define CAUSE_REGISTER  5'd13
`define EPC_REGISTER    5'd14

module cp0(rd_data, EPC, TakenInterrupt,
           wr_data, regnum, next_pc,
           MTC0, ERET, TimerInterrupt, clock, reset);
    output [31:0] rd_data;
    output [29:0] EPC;
    output        TakenInterrupt;
    input  [31:0] wr_data;
    input   [4:0] regnum;
    input  [29:0] next_pc;
    input         MTC0, ERET, TimerInterrupt, clock, reset;
    wire[31:0] user_status, decode, status_register, cause_register;
    wire[29:0] epc_d;
    wire reset_except, exception_level, epc_enable;

    // your Verilog for coprocessor 0 goes here
    assign cause_register = {16'b0, TimerInterrupt, 15'b0};
    assign status_register = {16'b0, user_status[15:8], 6'b0, exception_level, user_status[0]};
    assign TakenInterrupt = (cause_register[15] & status_register[15]) & ((~status_register[1]) & status_register[0]);
    decoder32 dec_reg(decode, regnum, MTC0);
    register #(32) user_reg(user_status, wr_data, clock, decode[12], reset);
    mux2v #(30) mux1(epc_d, wr_data[31:2], next_pc, TakenInterrupt);
    assign reset_except = reset | ERET;
    dffe exception_dffe(exception_level, 1'b1, clock, TakenInterrupt, reset_except);
    assign epc_enable = decode[14] | TakenInterrupt;
    register #(30) epc_reg(EPC, epc_d, clock, epc_enable, reset);
    mux32v #(32) mux2(rd_data, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, status_register, cause_register,
            {EPC, 2'b0}, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, regnum);
endmodule
