class Operation

  # The following notation applies to this summary:
  #
  #    A       Accumulator                  EOR     Logical Exclusive Or
  #    X, Y    Index Registers              fromS   Transfer from Stack
  #    M       Memory                       toS     Transfer to Stack
  #    P       Processor Status Register    ->      Transfer to
  #    S       Stack Pointer                <-      Transfer from
  #    /       Change                       ||      Logical OR
  #    _       No Change                    PC      Program Counter
  #    +       Add                          PCH     Program Counter High
  #    &&      Logical AND                  PCL     Program Counter Low
  #    -       Subtract                     OPER    Operand
  #                                         #       Immediate Addressing Mode
  Table = {

    adc: {
    # Operation:  A + M + C -> A, C
    #
    # N Z C I D V
    # / / / _ _ /
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         imm:          [  0x69,       2,        2     ],
         zp:           [  0x65,       2,        3     ],
         zpx:          [  0x75,       2,        4     ],
         abs:          [  0x60,       3,        4     ],
         absx:         [  0x70,       3,        4     ], # *
         absy:         [  0x79,       3,        4     ], # *
         preind:       [  0x61,       2,        6     ],
         postind:      [  0x71,       2,        5     ]},# *
    # +----------------+---------+---------+----------+
    # * Add 1 if page boundary is crossed.

    and: {
    # Operation:  A && M -> A
    #
    # N Z C I D V
    # / / _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         imm:          [  0x29,       2,        2     ],
         zp:           [  0x25,       2,        3     ],
         zpx:          [  0x35,       2,        4     ],
         abs:          [  0x2D,       3,        4     ],
         absx:         [  0x3D,       3,        4     ], # *
         absy:         [  0x39,       3,        4     ], # *
         preind:       [  0x21,       2,        6     ],
         postind:      [  0x31,       2,        5     ]},
    # +----------------+---------+---------+----------+
    # * Add 1 if page boundary is crossed.

    asl: {
    #                  +-+-+-+-+-+-+-+-+
    # Operation:  C <- |7|6|5|4|3|2|1|0| <- 0
    #                  +-+-+-+-+-+-+-+-+
    #
    # N Z C I D V
    # / / / _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         acc:          [  0x0A,       1,        2     ],
         zp:           [  0x06,       2,        5     ],
         zpx:          [  0x16,       2,        6     ],
         abs:          [  0x0E,       3,        6     ],
         absx:         [  0x1E,       3,        7     ]},
    # +----------------+---------+---------+----------+

    bcc: {
    # Operation:  Branch on C = 0
    #
    # N Z C I D V
    # _ _ _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         rel:          [  0x90,       2,        2     ]}, # *
    # +----------------+---------+---------+----------+
    # * Add 1 if branch occurs to same page.
    # * Add 2 if branch occurs to different page.

    bcs: {
    # Operation:  Branch on C = 1
    #
    # N Z C I D V
    # _ _ _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         rel:          [  0xB0,       2,        2     ]}, # *
    # +----------------+---------+---------+----------+
    # * Add 1 if branch occurs to same  page.
    # * Add 2 if branch occurs to next  page.

    beq: {
    # Operation:  Branch on Z = 1
    #
    # N Z C I D V
    # _ _ _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         rel:          [  0xF0,       2,        2     ]}, # *
    # +----------------+---------+---------+----------+
    # * Add 1 if branch occurs to same  page.
    # * Add 2 if branch occurs to next  page.

    bit: {
    # Operation:  A /\ M, M7 -> N, M6 -> V
    #
    # Bit 6 and 7 are transferred to the status register.
    # If the result of A /\ M is zero then Z = 1, otherwise
    # Z = 0
    #
    # N Z C I D V
    # M7/ _ _ _ M6
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         zp:           [  0x24,       2,        3     ],
         abs:          [  0x2C,       3,        4     ]},
    # +----------------+---------+---------+----------+

    bmi: {
    # Operation:  Branch on N = 1
    #
    # N Z C I D V
    # _ _ _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         rel:          [  0x30,       2,        2     ]}, # *
    # +----------------+---------+---------+----------+
    # * Add 1 if branch occurs to same page.
    # * Add 1 if branch occurs to different page.

    bne: {
    # Operation:  Branch on Z = 0
    #
    # N Z C I D V
    # _ _ _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         rel:          [  0xD0,       2,        2     ]}, # *
    # +----------------+---------+---------+----------+
    # * Add 1 if branch occurs to same page.
    # * Add 2 if branch occurs to different page.

    bpl: {
    # Operation:  Branch on N = 0
    #
    # N Z C I D V
    # _ _ _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         rel:          [  0x10,       2,        2     ]}, # *
    # +----------------+---------+---------+----------+
    # * Add 1 if branch occurs to same page.
    # * Add 2 if branch occurs to different page.

    brk: {
    # Operation:  Forced Interrupt PC + 2 toS P toS
    #
    # N Z C I D V
    # _ _ _ 1 _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         imp:          [  0x00,       1,        7     ]},
    # +----------------+---------+---------+----------+
    # 1. A BRK command cannot be masked by setting I.

    bvc: {
    # Operation:  Branch on V = 0
    #
    # N Z C I D V
    # _ _ _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         rel:          [  0x50,       2,        2     ]}, # *
    # +----------------+---------+---------+----------+
    # * Add 1 if branch occurs to same page.
    # * Add 2 if branch occurs to different page.

    bvs: {
    # Operation:  Branch on V = 1
    #
    # N Z C I D V
    # _ _ _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         rel:          [  0x70,       2,        2     ]}, # *
    # +----------------+---------+---------+----------+
    # * Add 1 if branch occurs to same page.
    # * Add 2 if branch occurs to different page.

    clc: {
    # Operation:  0 -> C
    #
    # N Z C I D V
    # _ _ 0 _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         imp:          [  0x18,       1,        2     ]},
    # +----------------+---------+---------+----------+

    cld: {
    # Operation:  0 -> D
    #
    # N A C I D V
    # _ _ _ _ 0 _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         imp:          [  0xD8,       1,        2     ]},
    # +----------------+---------+---------+----------+

    cli: {
    # Operation: 0 -> I
    #
    # N Z C I D V
    # _ _ _ 0 _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         imp:          [  0x58,       1,        2     ]},
    # +----------------+---------+---------+----------+

    clv: {
    # Operation: 0 -> V
    #
    # N Z C I D V
    # _ _ _ _ _ 0
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         imp:          [  0xB8,       1,        2     ]},
    # +----------------+---------+---------+----------+

    cmp: {
    # Operation:  A - M
    #
    # N Z C I D V
    # / / / _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         imm:          [  0xC9,       2,        2     ],
         zp:           [  0xC5,       2,        3     ],
         zpx:          [  0xD5,       2,        4     ],
         abs:          [  0xCD,       3,        4     ],
         absx:         [  0xDD,       3,        4     ], # *
         absy:         [  0xD9,       3,        4     ], # *
         preind:       [  0xC1,       2,        6     ],
         postind:      [  0xD1,       2,        5     ]}, # *
    # +----------------+---------+---------+----------+
    # * Add 1 if page boundary is crossed.

    cpx: {
    # Operation:  X - M
    #
    # N Z C I D V
    # / / / _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         imm:          [  0xE0,       2,        2     ],
         zp:           [  0xE4,       2,        3     ],
         abs:          [  0xEC,       3,        4     ]},
    # +----------------+---------+---------+----------+

    cpy: {
    # Operation:  Y - M
    #
    # N Z C I D V
    # / / / _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         imm:          [  0xC0,       2,        2     ],
         zp:           [  0xC4,       2,        3     ],
         abs:          [  0xCC,       3,        4     ]},
    # +----------------+---------+---------+----------+

    dec: {
    # Operation:  M - 1 -> M
    #
    # N Z C I D V
    # / / _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         zp:           [  0xC6,       2,        5     ],
         zpx:          [  0xD6,       2,        6     ],
         abs:          [  0xCE,       3,        6     ],
         absx:         [  0xDE,       3,        7     ]},
    # +----------------+---------+---------+----------+

    dex: {
    # Operation:  X - 1 -> X
    #
    # N Z C I D V
    # / / _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
          imp:          [  0xCA,       1,        2     ]},
    # +----------------+---------+---------+----------+

    dey: {
    # Operation:  X - 1 -> Y
    #
    # N Z C I D V
    # / / _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         imp:          [  0x88,       1,        2     ]},
    # +----------------+---------+---------+----------+

    eor: {
    # Operation:  A EOR M -> A
    #
    # N Z C I D V
    # / / _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         imm:          [  0x49,       2,        2     ],
         zp:           [  0x45,       2,        3     ],
         zpx:          [  0x55,       2,        4     ],
         abs:          [  0x40,       3,        4     ],
         absx:         [  0x50,       3,        4     ], # *
         absy:         [  0x59,       3,        4     ], # *
         preind:       [  0x41,       2,        6     ],
         postind:      [  0x51,       2,        5     ]},# *
    # +----------------+---------+---------+----------+
    # * Add 1 if page boundary is crossed.

    inc: {
    # Operation:  M + 1 -> M
    #
    # N Z C I D V
    # / / _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         zp:           [  0xE6,       2,        5     ],
         zpx:          [  0xF6,       2,        6     ],
         abs:          [  0xEE,       3,        6     ],
         absx:         [  0xFE,       3,        7     ]},
    # +----------------+---------+---------+----------+

    inx: {
    # Operation:  X + 1 -> X
    #
    # N Z C I D V
    # / / _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         imp:          [  0xE8,       1,        2     ]},
    # +----------------+---------+---------+----------+

    iny: {
    # Operation:  X + 1 -> X
    #
    # N Z C I D V
    # / / _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         imp:          [  0xC8,       1,        2     ]},
    # +----------------+---------+---------+----------+

    jmp: {
    # Operation:  (PC + 1) -> PCL
    #             (PC + 2) -> PCH
    #
    # N Z C I D V
    # _ _ _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         abs:          [  0x4C,       3,        3     ],
         absind:       [  0x6C,       3,        5     ]},
    # +----------------+---------+---------+----------+

    jsr: {
    # Operation:  PC + 2 toS, (PC + 1) -> PCL
    #                         (PC + 2) -> PCH
    #
    # N Z C I D V
    # _ _ _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         abs:          [  0x20,       3,        6     ]},
    # +----------------+---------+---------+----------+

    lda: {
    # Operation:  M -> A
    #
    # N Z C I D V
    # / / _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         imm:          [  0xA9,       2,        2     ],
         zp:           [  0xA5,       2,        3     ],
         zpx:          [  0xB5,       2,        4     ],
         abs:          [  0xAD,       3,        4     ],
         absx:         [  0xBD,       3,        4     ], # *
         absy:         [  0xB9,       3,        4     ], # *
         preind:       [  0xA1,       2,        6     ],
         postind:      [  0xB1,       2,        5     ]},# *
    # +----------------+---------+---------+----------+
    # * Add 1 if page boundary is crossed.

    ldx: {
    # Operation:  M -> X
    #
    # N Z C I D V
    # / / _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         imm:          [  0xA2,       2,        2     ],
         zp:           [  0xA6,       2,        3     ],
         zpy:          [  0xB6,       2,        4     ],
         abs:          [  0xAE,       3,        4     ],
         absy:         [  0xBE,       3,        4     ]},# *
    # +----------------+---------+---------+----------+
    # * Add 1 when page boundary is crossed.

    ldy: {
    # Operation:  M -> Y
    #
    # N Z C I D V
    # / / _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         imm:          [  0xA0,       2,        2     ],
         zp:           [  0xA4,       2,        3     ],
         zpx:          [  0xB4,       2,        4     ],
         abs:          [  0xAC,       3,        4     ],
         absx:         [  0xBC,       3,        4     ]},# *
    # +----------------+---------+---------+----------+
    # * Add 1 when page boundary is crossed.

    lsr: {
    #                  +-+-+-+-+-+-+-+-+
    # Operation:  0 -> |7|6|5|4|3|2|1|0| -> C
    #                  +-+-+-+-+-+-+-+-+
    #
    # N Z C I D V
    # 0 / / _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         acc:          [  0x4A,       1,        2     ],
         zp:           [  0x46,       2,        5     ],
         zpx:          [  0x56,       2,        6     ],
         abs:          [  0x4E,       3,        6     ],
         absx:         [  0x5E,       3,        7     ]},
    # +----------------+---------+---------+----------+

    nop: {
    # Operation:  No Operation (2 cycles)
    #
    # N Z C I D V
    # _ _ _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         imp:          [  0xEA,       1,        2     ]},
    # +----------------+---------+---------+----------+

    ora: {
    # Operation: A V M -> A
    #
    # N Z C I D V
    # / / _ _ _ _
    # +----------------+---------+---------+----------+
    # | Addressing Mode| OP CODE |No. Bytes|No. Cycles|
    # +----------------+---------+---------+----------+
         imm:          [  0x09,       2,        2     ],
         zp:           [  0x05,       2,        3     ],
         zpx:          [  0x15,       2,        4     ],
         abs:          [  0x0D,       3,        4     ],
         absx:         [  0x1D,       3,        4     ], # *
         absy:         [  0x19,       3,        4     ], # *
         preind:       [  0x01,       2,        6     ],
         postind:      [  0x11,       2,        5     ]},
    # +----------------+---------+---------+----------+
    # * Add 1 on page crossing

    pha: {imp:     [0x48, 1, 3]},
    php: {imp:     [0x08, 1, 3]},
    pla: {imp:     [0x68, 1, 4]},
    plp: {imp:     [0x28, 1, 4]},
    rol: {acc:     [0x2A, 1, 2],
          zp:      [0x26, 2, 5],
          zpx:     [0x36, 2, 6],
          abs:     [0x2E, 3, 6],
          absx:    [0x3E, 3, 7]},
    ror: {acc:     [0x6A, 1, 2],
          zp:      [0x66, 2, 5],
          zpx:     [0x76, 2, 6],
          abs:     [0x6E, 3, 6],
          absx:    [0x7E, 3, 7]},
    rti: {imp:     [0x40, 1, 6]},
    rts: {imp:     [0x60, 1, 6]},
    sbc: {imm:     [0xE9, 2, 2],
          zp:      [0xE5, 2, 3],
          zpx:     [0xF5, 2, 4],
          abs:     [0xED, 3, 4],
          absx:    [0xFD, 3, 4],
          absy:    [0xF9, 3, 4],
          preind:  [0xE1, 2, 6],
          postind: [0xF1, 2, 5]},
    sec: {imp:     [0x38, 1, 2]},
    sed: {imp:     [0xF8, 1, 2]},
    sei: {imp:     [0x78, 1, 2]},
    sta: {zp:      [0x85, 2, 3],
          zpx:     [0x95, 2, 4],
          abs:     [0x8D, 3, 4],
          absx:    [0x9D, 3, 5],
          absy:    [0x99, 3, 5],
          preind:  [0x81, 2, 6],
          postind: [0x91, 2, 6]},
    stx: {zp:      [0x86, 2, 3],
          zpy:     [0x96, 2, 4],
          abs:     [0x8E, 3, 4]},
    sty: {zp:      [0x84, 2, 3],
          zpx:     [0x94, 2, 4],
          abs:     [0x8C, 3, 4]},
    tax: {imp:     [0xAA, 1, 2]},
    tay: {imp:     [0xA8, 1, 2]},
    tsx: {imp:     [0xBA, 1, 2]},
    txa: {imp:     [0x8A, 1, 2]},
    txs: {imp:     [0x9A, 1, 2]},
    tya: {imp:     [0x98, 1, 2]}
  }

  Cycle = [
    7, 6, 2, 8, 3, 3, 5, 5, 3, 2, 2, 2, 4, 4, 6, 6, # 0x00
    2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7, # 0x10
    6, 6, 2, 8, 3, 3, 5, 5, 4, 2, 2, 2, 4, 4, 6, 6, # 0x20
    2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7, # 0x30
    6, 6, 2, 8, 3, 3, 5, 5, 3, 2, 2, 2, 3, 4, 6, 6, # 0x40
    2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7, # 0x50
    6, 6, 2, 8, 3, 3, 5, 5, 4, 2, 2, 2, 5, 4, 6, 6, # 0x60
    2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7, # 0x70
    2, 6, 2, 6, 3, 3, 3, 3, 2, 2, 2, 2, 4, 4, 4, 4, # 0x80
    2, 6, 2, 6, 4, 4, 4, 4, 2, 5, 2, 5, 5, 5, 5, 5, # 0x90
    2, 6, 2, 6, 3, 3, 3, 3, 2, 2, 2, 2, 4, 4, 4, 4, # 0xA0
    2, 5, 2, 5, 4, 4, 4, 4, 2, 4, 2, 4, 4, 4, 4, 4, # 0xB0
    2, 6, 2, 8, 3, 3, 5, 5, 2, 2, 2, 2, 4, 4, 6, 6, # 0xC0
    2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7, # 0xD0
    2, 6, 3, 8, 3, 3, 5, 5, 2, 2, 2, 2, 4, 4, 6, 6, # 0xE0
    2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7  # 0xF0
  ]

  def [](inst, addr)
    table[Table[inst][addr][0]]
  end

  def table
    @table ||= Array.new(256, 0xFF)
  end

  def initialize
    Table.each do |instruction, addresses|
      addresses.each do |address, (code, bytes, cycles)|

        inst = Instruction[:by_name][instruction]
        addr = Address[:by_name][address]

        table[code] = ((inst   & 0xFF))       |
                      ((addr   & 0xFF) << 8)  |
                      ((bytes  & 0xFF) << 16) |
                      ((cycles & 0xFF) << 24)

      end
    end
  end
end

