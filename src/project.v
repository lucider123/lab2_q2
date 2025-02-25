`default_nettype none

module tt_um_example (
    input wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,  // Dedicated outputs
    input wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out, // IOs: Output path
    output wire [7:0] uio_oe,  // IOs: Enable path (active high: 0=input, 1=output)
    input wire ena,            // always 1 when the design is powered, so you can ignore it
    input wire clk,            // clock
    input wire rst_n           // reset_n – low to reset
);

    // Priority Encoder Logic
    reg [7:0] out_reg;

    always @(*) begin
        casez (ui_in)
            8'b1???????: out_reg = 8'd7;
            8'b01??????: out_reg = 8'd6;
            8'b001?????: out_reg = 8'd5;
            8'b0001????: out_reg = 8'd4;
            8'b00001???: out_reg = 8'd3;
            8'b000001??: out_reg = 8'd2;
            8'b0000001?: out_reg = 8'd1;
            8'b00000001: out_reg = 8'd0;
            8'b00000000: out_reg = 8'b11110000; // No '1' found, special case
            default: out_reg = 8'd0;
        endcase
    end

    assign uo_out = out_reg;

    // Assign unused outputs to zero
    assign uio_out = 0;
    assign uio_oe = 0;

    // List all unused inputs to prevent warnings
    wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
