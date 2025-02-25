`default_nettype none

module tt_um_example (
    input wire [15:0] ui_in,   // Dedicated inputs (16-bit input)
    output wire [7:0] uo_out,  // Dedicated outputs (8-bit output)
    input wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out, // IOs: Output path
    output wire [7:0] uio_oe,  // IOs: Enable path (active high: 0=input, 1=output)
    input wire ena,            // always 1 when the design is powered, so you can ignore it
    input wire clk,            // clock
    input wire rst_n           // reset_n – low to reset
);

    // Priority Encoder Logic (16-bit)
    reg [7:0] out_reg;

    always @(*) begin
        if (!rst_n)
            out_reg = 8'b00000000;  // 复位时清零
        else begin
            casez (ui_in)
                16'b1???????????????: out_reg = 8'd15;
                16'b01??????????????: out_reg = 8'd14;
                16'b001?????????????: out_reg = 8'd13;
                16'b0001????????????: out_reg = 8'd12;
                16'b00001???????????: out_reg = 8'd11;
                16'b000001??????????: out_reg = 8'd10;
                16'b0000001?????????: out_reg = 8'd9;
                16'b00000001????????: out_reg = 8'd8;
                16'b000000001???????: out_reg = 8'd7;
                16'b0000000001??????: out_reg = 8'd6;
                16'b00000000001?????: out_reg = 8'd5;
                16'b000000000001????: out_reg = 8'd4;
                16'b0000000000001???: out_reg = 8'd3;
                16'b00000000000001??: out_reg = 8'd2;
                16'b000000000000001?: out_reg = 8'd1;
                16'b0000000000000001: out_reg = 8'd0;
                16'b0000000000000000: out_reg = 8'b11110000; // 特殊情况，无 "1"
                default: out_reg = 8'd0;
            endcase
        end
    end

    assign uo_out = out_reg;

    // Assign unused outputs to zero
    assign uio_out = 0;
    assign uio_oe = 0;

    // List all unused inputs to prevent warnings
    wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
