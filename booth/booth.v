module array8_spst_pipe3 (
    input  wire         clk,
    input  wire         rst_n,     // Active-low reset
    input  wire         en,        // Input valid
    input  wire [7:0]   a_i,
    input  wire [7:0]   b_i,
    output reg  [15:0]  p_o,
    output reg          valid_o
);

    // Stage 1: Partial product generation with SPST-style gating
    wire [15:0] v0 = {8'b0, (a_i & {8{b_i[0]}})} << 0;
    wire [15:0] v1 = {8'b0, (a_i & {8{b_i[1]}})} << 1;
    wire [15:0] v2 = {8'b0, (a_i & {8{b_i[2]}})} << 2;
    wire [15:0] v3 = {8'b0, (a_i & {8{b_i[3]}})} << 3;
    wire [15:0] v4 = {8'b0, (a_i & {8{b_i[4]}})} << 4;
    wire [15:0] v5 = {8'b0, (a_i & {8{b_i[5]}})} << 5;
    wire [15:0] v6 = {8'b0, (a_i & {8{b_i[6]}})} << 6;
    wire [15:0] v7 = {8'b0, (a_i & {8{b_i[7]}})} << 7;

    // Pipeline registers - Stage 1
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
            vld1_r <= en;
        end
    end

    // Stage 2: Balanced adder tree
    wire [15:0] t0 = v0_r + v1_r;
    wire [15:0] t1 = v2_r + v3_r;
    wire [15:0] t2 = v4_r + v5_r;
    wire [15:0] t3 = v6_r + v7_r;

    // Pipeline registers - Stage 2
    reg [15:0] t0_r, t1_r, t2_r, t3_r;
    reg        vld2_r;

    always @(posedge clk) begin
        if (!rst_n) begin
            t0_r <= 16'd0; t1_r <= 16'd0;
            t2_r <= 16'd0; t3_r <= 16'd0;
            vld2_r <= 1'b0;
        end else begin
            t0_r <= t0; t1_r <= t1;
            t2_r <= t2; t3_r <= t3;
            vld2_r <= vld1_r;
        end
    end

    // Stage 3: Final addition
    wire [15:0] g0 = t0_r + t1_r;
    wire [15:0] g1 = t2_r + t3_r;
    wire [15:0] product = g0 + g1;

    always @(posedge clk) begin
        if (!rst_n) begin
            p_o     <= 16'd0;
            valid_o <= 1'b0;
        end else begin
            p_o     <= product;
            valid_o <= vld2_r;
        end
    end
  
endmodule   
