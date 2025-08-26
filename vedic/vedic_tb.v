   `timescale 1ns/1ps
module tb_vedic_multiplier;

    reg clk, rst, valid_i;
    reg [7:0] a, b;
    wire [15:0] product;
    wire valid_o;

    // Shadow registers to store input for verification
    reg [7:0] a_saved, b_saved;

    // Instantiate DUT
    vedic_8x8_pipelined_spst uut (
        .clk(clk),
        .rst(rst),
        .valid_i(valid_i),
        .a(a),
        .b(b),
        .product(product),
        .valid_o(valid_o)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz
    end

    // Input stimulus
    initial begin
        $display("Starting Testbench for Vedic Multiplier with SPST...");
        rst = 1; valid_i = 0; a = 0; b = 0;
        #15 rst = 0;

        send(8'd5, 8'd3);     // Expected: 15
        send(8'd0, 8'd100);   // Expected: 0
        send(8'd12, 8'd12);   // Expected: 144
        send(8'd255, 8'd1);   // Expected: 255
        send(8'd50, 8'd2);    // Expected: 100
        send(8'd7, 8'd7);     // Expected: 49
        send(8'd200, 8'd3);   // Expected: 600
        send(8'd128, 8'd2);   // Expected: 256
        send(8'd15, 8'd15);   // Expected: 225
        send(8'd255, 8'd255); // Expected: 65025

        #200;
        $display("Test Completed.");
        $finish;
    end

    task send(input [7:0] x, input [7:0] y);
        begin
            @(posedge clk);
            valid_i = 1;
            a = x;
            b = y;
            a_saved = x;
            b_saved = y;
            @(posedge clk);
            valid_i = 0;
        end
    endtask

    // Monitor output
    always @(posedge clk) begin
        if (valid_o) begin
            $display("Time=%0t | a=%d b=%d | Product=%d", $time, a_saved, b_saved, product);
        end
    end
