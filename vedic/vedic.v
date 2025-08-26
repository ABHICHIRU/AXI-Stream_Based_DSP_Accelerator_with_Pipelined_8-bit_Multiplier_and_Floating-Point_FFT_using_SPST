`timescale 1ns/1ps
module vedic_8x8_pipelined_spst (
    input wire clk,
    input wire rst,
    input wire [7:0] a,
    input wire [7:0] b,
    input wire valid_i,
    output reg [15:0] product,
    output reg valid_o
);

    // Pipeline registers
    reg [7:0] a_reg1, b_reg1;
    reg [15:0] partial1, partial2;
    reg valid_stage1, valid_stage2;

    // SPST signal based on registered values
    wire skip_mult;
    assign skip_mult = (a_reg1 == 8'b0) || (b_reg1 == 8'b0);

    // Stage 1: Input Registering
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            a_reg1 <= 8'b0;
            b_reg1 <= 8'b0;
            valid_stage1 <= 1'b0;
        end else if (valid_i) begin
            a_reg1 <= a;
            b_reg1 <= b;
            valid_stage1 <= 1'b1;
        end else begin
            valid_stage1 <= 1'b0;
        end
    end

    // Stage 2: Partial Product Generation using 4x4 Vedic
    wire [3:0] a_low  = a_reg1[3:0];
    wire [3:0] a_high = a_reg1[7:4];
    wire [3:0] b_low  = b_reg1[3:0];
    wire [3:0] b_high = b_reg1[7:4];

    wire [7:0] p0 = skip_mult ? 8'd0 : (a_low  * b_low);
    wire [7:0] p1 = skip_mult ? 8'd0 : (a_high * b_low);
    wire [7:0] p2 = skip_mult ? 8'd0 : (a_low  * b_high);
    wire [7:0] p3 = skip_mult ? 8'd0 : (a_high * b_high);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            partial1 <= 16'd0;
            partial2 <= 16'd0;
            valid_stage2 <= 1'b0;
        end else if (valid_stage1) begin
            partial1 <= {8'd0, p0}; // LSB product
            partial2 <= (({8'd0, p1} << 4) + ({8'd0, p2} << 4) + (p3 << 8));
            valid_stage2 <= 1'b1;
        end else begin
            valid_stage2 <= 1'b0;
        end
    end

    // Stage 3: Final Addition
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            product <= 16'd0;
            valid_o <= 1'b0;
        end else if (valid_stage2) begin
            product <= partial1 + partial2;
            valid_o <= 1'b1;
        end else begin
            valid_o <= 1'b0;
        end
    end

endmodule       

 
endmodule
