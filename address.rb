Address = {

  # Instructions need operands to work on. There are various ways of indicating
  # where the processor is to get these operands. The different methdods used
  # to this are called addressing modes. The 6502 offers 11 modes, as described
  # below:

  zp: 0, # (zero page) In this mode the operands address is given.
  # If the address is on zero page - i.e. any address where the high byte is
  # 00 - only 1 byte is needed for the address. The processor automatically
  # fills the 00 high byte.
  # eg.  LDA  0xF4
  #      0xA5 0xF4
  # Note that for 2 byte addresses, the low byte is store first, eg.
  # LDA 0x31F6 is stored as three bytes in memory, 0xAD 0xF6 0x31.

  rel: 1, # (relative) This mode is used with Branch-on-Condition instructions.
  # It is probably the mode you will use most often. A 1 byte value is added
  # to the program counter, and the program continues execution from that
  # address.  The 1 byte number is treated as a signed number - i.e. if bit
  # 7 is 1, the number given by bits 0-6 is negative; if bit 7 is 0, the
  # number is positive. This enables a branch displacement of up to 127 bytes
  # in either direction.
  # eg  bit no.  7 6 5 4 3 2 1 0    signed value          unsigned value
  #     value    1 0 1 0 0 1 1 1    -39                   0xA7
  #     value    0 0 1 0 0 1 1 1    +39                   0x27
  # Instruction example:
  #   BEQ  0xA7
  #   0xF0 0xA7
  # This instruction will check the zero status bit. If it is set, 39 decimal
  # will be subtracted from the program counter and execution continues from
  # that address. If the zero status bit is not set, execution continues from
  # the following instruction.
  # Notes:  a) The program counter points to the start of the instruction
  # after the branch instruction before the branch displacement is added.
  # Remember to take this into account when calculating displacements.
  #         b) Branch-on-condition instructions work by checking the relevant
  # status bits in the status register. Make sure that they have been set or
  # unset as you want them. This is often done using a CMP instruction.
  #         c) If you find you need to branch further than 127 bytes, use the
  # opposite branch-on-condition and a JMP.

  imp: 2, # (implied) No operand addresses are required for this mode. They are
  # implied by the instruction.
  # eg.  TAX - (transfer accumulator contents to index x)
  #      0xAA

  abs: 3, # (absolute) In this mode the operands address is given.
  # eg.  LDA  0x31F6 - (assembler)
  #      0xAD 0x31F6 - (machine code)
  # Note that for 2 byte addresses, the low byte is store first, eg.
  # LDA 0x31F6 is stored as three bytes in memory, 0xAD 0xF6 0x31.

  acc: 4, # (accumulator) In this mode the instruction operates on data in the
  # accumulator, so no operands are needed.
  # eg.  LSR - logical bit shift right
  #      0x4A

  imm: 5, # (immediate) In this mode the operand's value is given in the instruction
  # itself. In assembly language this is indicated by "#" before the operand.
  # eg.  LDA 0x0A - means "load the accumulator with the hex value 0A"
  # In machine code different modes are indicated by different codes. So LDA
  # would be translated into different codes depending on the addressing mode.
  # In this mode, it is: 0xA9 0x0A

  zpx: 6, zpy: 7, absx: 8, absy: 9, # (zero page x/y and absolute x/y) In these modes
  # the address given is added to the value in either the X or Y index
  # register to give the actual address of the operand.
  # eg.  LDA  0x31F6, Y
  #      0xD9 0x31F6
  #      LDA  0x31F6, X
  #      0xDD 0x31F6
  # Note that the different operation codes determine the index register used.
  # In the zero-page version, you should note that the X and Y registers are
  # not interchangeable. Most instructions which can be used with zero-page
  # indexing do so with X only.
  # eg.  LDA  0x20, X
  #      0xB5 0x20

  preind: 10, # (preindexed indirect) In this mode a zer0-page address is added
  # to the contents of the X-register to give the address of the bytes holding
  # the address of the operand. The indirection is indicated by parenthesis in
  # assembly language.
  # eg.  LDA (0x3E, X)
  #      0xA1 0x3E
  # Assume the following -        byte      value
  #                               X-reg.    0x05
  #                               0x0043    0x15
  #                               0x0044    0x24
  #                               0x2415    0x6E
  # Then the instruction is executed by:
  # (i)   adding 0x3E and 0x05 = 0x0043
  # (ii)  getting address contained in bytes 0x0043, 0x0044 = 0x2415
  # (iii) loading contents of 0x2415 - i.e. 0x6E - into accumulator
  # Note a) When adding the 1-byte address and the X-register, wrap around
  #         addition is used - i.e. the sum is always a zero-page address.
  #         eg. FF + 2 = 0001 not 0101 as you might expect.
  #         DON'T FORGET THIS WHEN EMULATING THIS MODE.
  #      b) Only the X register is used in this mode.

  postind: 11, # (postindexed indirect) In this mode the contents of a zero-page address
  # (and the following byte) give the indirect addressm which is added to the
  # contents of the Y-register to yield the actual address of the operand.
  # Again, inassembly language, the instruction is indicated by parenthesis.
  # eg.  LDA (0x4C), Y
  # Note that the parenthesis are only around the 2nd byte of the instruction
  # since it is the part that does the indirection.
  # Assume the following -        byte       value
  #                               0x004C     0x00
  #                               0x004D     0x21
  #                               Y-reg.     0x05
  #                               0x2105     0x6D
  # Then the instruction above executes by:
  # (i)   getting the address in bytes 0x4C, 0x4D = 0x2100
  # (ii)  adding the contents of the Y-register = 0x2105
  # (111) loading the contents of the byte 0x2105 - i.e. 0x6D into the
  #       accumulator.
  # Note: only the Y-register is used in this mode.

  absind: 12  # (absolute indirect) This mode applies only to the JMP instruction
  # - JuMP to new location. It is indicated by parenthesis around the operand.
  # The operand is the address of the bytes whose value is the new location.
  # eg.  JMP (0x215F)
  # Assume the following -        byte      value
  #                               0x215F    0x76
  #                               0x2160    0x30
  # This instruction takes the value of bytes 0x215F, 0x2160 and uses that as
  # the address to jump to - i.e. 0x3076 (remember that addresses are stored
  # with low byte first).
}


