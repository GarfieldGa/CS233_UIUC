module timer(TimerInterrupt, cycle, TimerAddress,
             data, address, MemRead, MemWrite, clock, reset);
    output        TimerInterrupt;
    output [31:0] cycle;
    output        TimerAddress;
    input  [31:0] data, address;
    input         MemRead, MemWrite, clock, reset;
    wire reset_interrupt_line, acknowledge;
    wire[31:0] next_count, interrupt, count;
    wire negative, zero;
    wire timewrite, timeread, eq_count, eq_addr, eq_addr2;

    // complete the timer circuit here

    // HINT: make your interrupt cycle register reset to 32'hffffffff
    //       (using the reset_value parameter)
    //       to prevent an interrupt being raised the very first cycle
    register #(32) cycle_counter(count, next_count, clock, 1'b1, reset);
    alu32 ALU(next_count, zero, negative, `ALU_ADD, count, 32'b1);
    register #(32, 32'hffffffff) interrupt_cycle(interrupt, data, clock, timewrite, reset);
    assign eq_count = count == interrupt;
    assign reset_interrupt_line = acknowledge | reset;
    dffe interrupt_line(TimerInterrupt, 1'b1, clock, eq_count, reset_interrupt_line);
    assign eq_addr = 32'hffff001c == address;
    assign eq_addr2 = 32'hffff006c == address;
    assign timeread = eq_addr & MemRead;
    assign timewrite = eq_addr & MemWrite;
    assign acknowledge = eq_addr2 & MemWrite;
    assign TimerAddress = eq_addr | eq_addr2;
    tristate #(32) tri_cycle(cycle, count, timeread);
endmodule
