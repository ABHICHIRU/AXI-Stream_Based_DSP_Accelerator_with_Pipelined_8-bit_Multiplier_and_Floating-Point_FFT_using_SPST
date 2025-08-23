`timescale 1ns/1ps
module tb_booth_multiplier_8bit();

    reg clk, rst;
    reg [7:0] A, B;
    wire [15:0] P;

    booth_multiplier_8bit uut (
        .clk(clk),
        .rst(rst),
        .A(A),
        .B(B),
        .P(P)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Apply test cases
    initial begin
        $dumpfile("tb_booth_multiplier_8bit.vcd");
        $dumpvars(0, tb_booth_multiplier_8bit);

        rst = 1; A = 0; B = 0;
        #10 rst = 0;

        // Test Case 1: Both zero
        A = 8'd0; B = 8'd0; #20;

        // Test Case 2: One zero, other non-zero
        A = 8'd50; B = 8'd0; #20;

        // Test Case 3: Both positive small numbers
        A = 8'd5; B = 8'd7; #20;

        // Test Case 4: Both maximum values
        A = 8'd255; B = 8'd255; #20;

        // Test Case 5: Positive * Negative (Signed scenario mimic)
        A = 8'd10; B = -8'd4; #20;

        // Test Case 6: Negative * Negative
        A = -8'd15; B = -8'd2; #20;

        // Test Case 7: Alternating bits
        A = 8'b10101010; B = 8'b01010101; #20;

        // Test Case 8: One near max, one small
        A = 8'd250; B = 8'd3; #20;

        // Test Case 9: Random mid-range
        A = 8'd123; B = 8'd45; #20;

        // Test Case 10: Another random
        A = 8'd77; B = 8'd88; #20;

        $display("Simulation Complete");
        $finish;
    end

endmodule
