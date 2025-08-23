`timescale 1ns/1ps
// -----------------------------------------------------------------------------
// 8-bit Wallace-Tree Multiplier with SPST-style row gating and 3-stage pipeline
// Cadence-compatible Verilog-2001 (synthesizable)
// Stages:
//   S1: Row-gated partial products -> regs
//   S2: CSA reduction (two layers) -> regs
//   S3: Final CSA + CPA -> output regs
// Latency (en -> valid_o): 3 stages (data & valid aligned at S3)
// -----------------------------------------------------------------------------

module wallace8_spst_pipe3 (
    input  wire         clk,
    input  wire         rst_n,   // active-low, synchronous
    input  wire         en,      // sample-enable for S1 regs
    input  wire [7:0]   a_i,
    input  wire [7:0]   b_i,
    output reg  [15:0]  p_o,
    output reg          valid_o
);
    // ----------------------------
    // Stage 1: Row-gated partials
    // ----------------------------
    // Generate aligned 16-bit rows; gating prevents toggling when b_i[i]=0
    wire [15:0] v0 = {{8{1'b0}}, (a_i & {8{b_i[0]}})} << 0;
    wire [15:0] v1 = {{8{1'b0}}, (a_i & {8{b_i[1]}})} << 1;
    wire [15:0] v2 = {{8{1'b0}}, (a_i & {8{b_i[2]}})} << 2;
    wire [15:0] v3 = {{8{1'b0}}, (a_i & {8{b_i[3]}})} << 3;
    wire [15:0] v4 = {{8{1'b0}}, (a_i & {8{b_i[4]}})} << 4;
    wire [15:0] v5 = {{8{1'b0}}, (a_i & {8{b_i[5]}})} << 5;
    wire [15:0] v6 = {{8{1'b0}}, (a_i & {8{b_i[6]}})} << 6;
    wire [15:0] v7 = {{8{1'b0}}, (a_i & {8{b_i[7]}})} << 7;

    reg [15:0] v0_r, v1_r, v2_r, v3_r, v4_r, v5_r, v6_r, v7_r;
    reg        vld1_r;

    always @(posedge clk) begin
        if (!rst_n) begin
            v0_r <= 16'd0; v1_r <= 16'd0; v2_r <= 16'd0; v3_r <= 16'd0;
            v4_r <= 16'd0; v5_r <= 16'd0; v6_r <= 16'd0; v7_r <= 16'd0;
            vld1_r <= 1'b0;
        end else begin
            if (en) begin
                v0_r <= v0; v1_r <= v1; v2_r <= v2; v3_r <= v3;
                v4_r <= v4; v5_r <= v5; v6_r <= v6; v7_r <= v7;
            end
            vld1_r <= en; // propagate validity
        end
    end

    // -----------------------------------------
    // Stage 2: Wallace-like CSA reduction (2L)
    // -----------------------------------------
    wire [15:0] s01, c01, s23, c23, s45, c45;
    csa16 u_csa01 (.a(v0_r), .b(v1_r), .c(v2_r), .sum(s01), .carry(c01));
    csa16 u_csa23 (.a(v3_r), .b(v4_r), .c(v5_r), .sum(s23), .carry(c23));
    csa16 u_csa45 (.a(v6_r), .b(v7_r), .c(16'h0000), .sum(s45), .carry(c45));

    wire [15:0] sA, cA, sB, cB;
    csa16 u_csaA (.a(s01),            .b(s23),            .c(s45),        .sum(sA), .carry(cA));
    csa16 u_csaB (.a({c01,1'b0}),     .b({c23,1'b0}),     .c({c45,1'b0}), .sum(sB), .carry(cB));

    reg  [15:0] sA_r, cA_r, sB_r, cB_r;
    reg         vld2_r;

    always @(posedge clk) begin
        if (!rst_n) begin
            sA_r <= 16'd0; cA_r <= 16'd0; sB_r <= 16'd0; cB_r <= 16'd0;
            vld2_r <= 1'b0;
        end else begin
            sA_r <= sA; cA_r <= cA; sB_r <= sB; cB_r <= cB;
            vld2_r <= vld1_r;
        end
    end

    // -----------------------------------------
    // Stage 3: Final CSA + CPA -> output regs
    // -----------------------------------------
    wire [15:0] sC, cC;
    csa16 u_csaC (.a(sA_r), .b(sB_r), .c({cA_r,1'b0}), .sum(sC), .carry(cC));

    wire [15:0] final_sum  = sC;
    wire [15:0] final_carr = {cC, 1'b0};
    wire [15:0] product_w  = final_sum + final_carr; // ripple/CLA in synthesis

    always @(posedge clk) begin
        if (!rst_n) begin
            p_o     <= 16'd0;
            valid_o <= 1'b0;
        end else begin
            p_o     <= product_w;
            valid_o <= vld2_r; // aligned with S3 data
        end
    end

endmodule

// 16-bit bitwise 3:2 compressor (carry is unshifted; we append <<1 where needed)
module csa16 (
    input  wire [15:0] a,
    input  wire [15:0] b,
    input  wire [15:0] c,
    output wire [15:0] sum,
    output wire [15:0] carry
);
    assign sum   = a ^ b ^ c;
    assign carry = (a & b) | (b & c) | (a & c);
endmodule
