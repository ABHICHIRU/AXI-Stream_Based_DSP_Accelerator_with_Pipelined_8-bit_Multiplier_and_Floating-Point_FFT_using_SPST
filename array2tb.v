`timescale 1ns/1ns

module tb_array8_spst_pipe3;

    reg clk;
    reg rst_n;
    reg en;
    reg [7:0] a_i, b_i;
    wire [15:0] p_o;
    wire valid_o;

    array8_spst_pipe3 dut (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .a_i(a_i),
        .b_i(b_i),
        .p_o(p_o),
        .valid_o(valid_o)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 100 MHz

    // Test sequence
    initial begin
        $display("Starting Cadence-compatible testbench for array8_spst_pipe3...");
        rst_n = 0; en = 0; a_i = 0; b_i = 0;

        @(posedge clk); rst_n = 1;

        send(8'd0,   8'd0);    // 0
        send(8'd1,   8'd1);    // 1
        send(8'd15,  8'd10);   // 150
        send(8'd255, 8'd1);    // 255
        send(8'd12,  8'd12);   // 144
        send(8'd200, 8'd3);    // 600
        send(8'd8,   8'd25);   // 200
        send(8'd100, 8'd100);  // 10000
        send(8'd255, 8'd255);  // 65025
        send(8'd7,   8'd13);   // 91

        en = 0;
        repeat(10) @(posedge clk);
        $display("Testbench finished.");
        $finish;
    end

    task send(input [7:0] a, input [7:0] b);
        begin
            @(posedge clk);
            en <= 1;
            a_i <= a;
            b_i <= b;
        end
    endtask

    // Monitor product output
    always @(posedge clk) begin
        if (valid_o)
            $display("Time=%t | a=%d b=%d -> product=%d", $time, a_i, b_i, p_o);
    end

endmodule
