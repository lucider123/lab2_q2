import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_priority_encoder(dut):
    """ Test the priority encoder """

    # 生成时钟
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # 复位电路
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 1)

    # 测试用例
    test_vectors = [
        (0b10101111, 7),  # 最高位是 7
        (0b00001000, 3),  # 最高位是 3
        (0b00000001, 0),  # 最高位是 0
        (0b00000000, 240) # 无 '1'，返回 1111 0000
    ]

    for in_val, expected_out in test_vectors:
        dut.ui_in.value = in_val
        await ClockCycles(dut.clk, 1)
        assert dut.uo_out.value == expected_out, f"Error: Input {bin(in_val)}, Expected {expected_out}, Got {dut.uo_out.value}"
