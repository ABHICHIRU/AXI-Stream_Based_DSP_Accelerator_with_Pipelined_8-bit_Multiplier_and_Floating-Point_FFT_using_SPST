`timescale 1ns/1ps

module tb_wallace8_spst_pipe3;

    reg         clk;
    reg         rst_n;
    reg         en;
    reg  [7:0]  a_i;
    reg  [7:0]  b_i;
    wire [15:0] p_o;
    wire        valid_o;

    wallace8_spst_pipe3 dut (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .a_i(a_i),
        .b_i(b_i),
        .p_o(p_o),
        .valid_o(valid_o)
    );

    // 10 ns clock
    initial clk = 1'b0;
    always #5 clk = ~clk;

    // Apply one vector per cycle (streaming)
    task apply_vec;
        input [7:0] a;
        input [7:0] b;
        begin
            @(posedge clk);
            en  <= 1'b1;
            a_i <= a;
            b_i <= b;
        end
    endtask

    initial begin
        // Wave dump (VCD works in Xcelium; SHM also available via -shm switch)
        $dumpfile("wallace8_spst_pipe3.vcd");
        $dumpvars(0, tb_wallace8_spst_pipe3);

        // Reset
        en   = 1'b0;
        a_i  = 8'd0;
        b_i  = 8'd0;
        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        rst_n = 1'b1;

        // Unique & diverse stimulus (unsigned here)
        apply_vec(8'd0  , 8'd0  ); // 0 * 0 = 0
        apply_vec(8'd1  , 8'd255); // small * max
        apply_vec(8'd255, 8'd1  ); // max * small
        apply_vec(8'd128, 8'd2  ); // power-of-two shift
        apply_vec(8'd85 , 8'd170); // 0x55 * 0xAA (alt bits)
        apply_vec(8'd15 , 8'd15 ); // square mid value
        apply_vec(8'd200, 8'd50 ); // random mid-highs
        apply_vec(8'd7  , 8'd13 ); // primes
        apply_vec(8'd100, 8'd0  ); // zero second
        apply_vec(8'd0  , 8'd150); // zero first

        // stop streaming
        @(posedge clk);
        en <= 1'b0;

        // let pipeline flush
        repeat (8) @(posedge clk);
        $stop; // use $stop for Cadence waveform inspection
    end

    // Simple live monitor
    initial begin
        $display("  time  | en v |  a   b  | product");
        forever begin
            @(posedge clk);
            $display("%7t | %1b  %1b | %3d %3d | %5d",
                     $time, en, valid_o, a_i, b_i, p_o);
        end
    end

endmodule
