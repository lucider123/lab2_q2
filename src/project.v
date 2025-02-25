/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    always @(*) begin
    if (In == 16'b0) begin
        C = 8'b1111_0000;
    end else begin
        casez (In)
            16'b1????_????_????_????: C = 8'b0000_1111;  // 位置 15
            16'b01???_????_????_????: C = 8'b0000_1110;  // 位置 14
            16'b001?_????_????_????: C = 8'b0000_1101;   // 位置 13
            16'b0001_????_????_????: C = 8'b0000_1100;   // 位置 12
            16'b0000_1???_????_????: C = 8'b0000_1011;   // 位置 11
            16'b0000_01??_????_????: C = 8'b0000_1010;   // 位置 10
            16'b0000_001?_????_????: C = 8'b0000_1001;   // 位置 9
            16'b0000_0001_????_????: C = 8'b0000_1000;   // 位置 8
            16'b0000_0000_1???_????: C = 8'b0000_0111;   // 位置 7
            16'b0000_0000_01??_????: C = 8'b0000_0110;   // 位置 6
            16'b0000_0000_001?_????: C = 8'b0000_0101;   // 位置 5
            16'b0000_0000_0001_????: C = 8'b0000_0100;   // 位置 4
            16'b0000_0000_0000_1???: C = 8'b0000_0011;   // 位置 3
            16'b0000_0000_0000_01??: C = 8'b0000_0010;   // 位置 2
            16'b0000_0000_0000_001?: C = 8'b0000_0001;   // 位置 1
            16'b0000_0000_0000_0001: C = 8'b0000_0000;   // 位置 0
            default: C = 8'b1111_0000;  // 安全默认值
        endcase
    end
end

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out  = C;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;
    

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
