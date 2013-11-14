class Operation

  Table = {
    adc: {imm:     [0x69, 2, 2],
          zp:      [0x65, 2, 3],
          zpx:     [0x75, 2, 4],
          abs:     [0x6D, 3, 4],
          absx:    [0x7D, 3, 4],
          absy:    [0x79, 3, 4],
          preind:  [0x61, 2, 6],
          postind: [0x71, 2, 5]},
    and: {imm:     [0x29, 2, 2],
          zp:      [0x25, 2, 3],
          zpx:     [0x35, 2, 4],
          abs:     [0x2D, 3, 4],
          absx:    [0x3D, 3, 4],
          absy:    [0x39, 3, 4],
          preind:  [0x21, 2, 6],
          postind: [0x31, 2, 5]},
    asl: {acc:     [0x0A, 1, 2],
          zp:      [0x06, 2, 5],
          zpx:     [0x16, 2, 6],
          abs:     [0x0E, 3, 6],
          absx:    [0x1E, 3, 7]},
    bcc: {rel:     [0x90, 2, 2]},
    bcs: {rel:     [0xB0, 2, 2]},
    beq: {rel:     [0xF0, 2, 2]},
    bit: {zp:      [0x24, 2, 3],
          abs:     [0x2C, 3, 4]},
    bmi: {rel:     [0x30, 2, 2]},
    bne: {rel:     [0xD0, 2, 2]},
    bpl: {rel:     [0x10, 2, 2]},
    brk: {imp:     [0x00, 1, 7]},
    bvc: {rel:     [0x50, 2, 2]},
    bvs: {rel:     [0x70, 2, 2]},
    clc: {imp:     [0x18, 1, 2]},
    cld: {imp:     [0xD8, 1, 2]},
    cli: {imp:     [0x58, 1, 2]},
    clv: {imp:     [0xB8, 1, 2]},
    cmp: {imm:     [0xC9, 2, 2],
          zp:      [0xC5, 2, 3],
          zpx:     [0xD5, 2, 4],
          abs:     [0xCD, 3, 4],
          absx:    [0xDD, 3, 4],
          absy:    [0xD9, 3, 4],
          preind:  [0xC1, 2, 6],
          postind: [0xD1, 2, 5]},
    cpx: {imm:     [0xE0, 2, 2],
          zp:      [0xE4, 2, 3],
          abs:     [0xEC, 3, 4]},
    cpy: {imm:     [0xC0, 2, 2],
          zp:      [0xC4, 2, 3],
          abs:     [0xCC, 3, 4]},
    dec: {zp:      [0xC6, 2, 5],
          zpx:     [0xD6, 2, 6],
          abs:     [0xCE, 3, 6],
          absx:    [0xDE, 3, 7]},
    dex: {imp:     [0xCA, 1, 2]},
    dey: {imp:     [0x88, 1, 2]},
    eor: {imm:     [0x49, 2, 2],
          zp:      [0x45, 2, 3],
          zpx:     [0x55, 2, 4],
          abs:     [0x4D, 3, 4],
          absx:    [0x5D, 3, 4],
          absy:    [0x59, 3, 4],
          preind:  [0x41, 2, 6],
          postind: [0x51, 2, 5]},
    inc: {zp:      [0xE6, 2, 5],
          zpx:     [0xF6, 2, 6],
          abs:     [0xEE, 3, 6],
          absx:    [0xFE, 3, 7]},
    inx: {imp:     [0xE8, 1, 2]},
    iny: {imp:     [0xC8, 1, 2]},
    jmp: {abs:     [0x4C, 3, 3],
          absind:  [0x6C, 3, 5]},
    jsr: {abs:     [0x20, 3, 6]},
    lda: {imm:     [0xA9, 2, 2],
          zp:      [0xA5, 2, 3],
          zpx:     [0xB5, 2, 4],
          abs:     [0xAD, 3, 4],
          absx:    [0xBD, 3, 4],
          absy:    [0xB9, 3, 4],
          preind:  [0xA1, 2, 6],
          postind: [0xB1, 2, 5]},
    ldx: {imm:     [0xA2, 2, 2],
          zp:      [0xA6, 2, 3],
          zpy:     [0xB6, 2, 4],
          abs:     [0xAE, 3, 4],
          absy:    [0xBE, 3, 4]},
    ldy: {imm:     [0xA0, 2, 2],
          zp:      [0xA4, 2, 3],
          zpx:     [0xB4, 2, 4],
          abs:     [0xAC, 3, 4],
          absx:    [0xBC, 3, 4]},
    lsr: {acc:     [0x4A, 1, 2],
          zp:      [0x46, 2, 5],
          zpx:     [0x56, 2, 6],
          abs:     [0x4E, 3, 6],
          absx:    [0x5E, 3, 7]},
    nop: {imp:     [0xEA, 1, 2]},
    ora: {imm:     [0x09, 2, 2],
          zp:      [0x05, 2, 3],
          zpx:     [0x15, 2, 4],
          abs:     [0x0D, 3, 4],
          absx:    [0x1D, 3, 4],
          absy:    [0x19, 3, 4],
          preind:  [0x01, 2, 6],
          postind: [0x11, 2, 5]},
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
     7,  6,  2,  8,  3,  3,  5,  5,  3,  2,  2,  2,  4,  4,  6,  6, # 0x00
     2,  5,  2,  8,  4,  4,  6,  6,  2,  4,  2,  7,  4,  4,  7,  7, # 0x10
     6,  6,  2,  8,  3,  3,  5,  5,  4,  2,  2,  2,  4,  4,  6,  6, # 0x20
     2,  5,  2,  8,  4,  4,  6,  6,  2,  4,  2,  7,  4,  4,  7,  7, # 0x30
     6,  6,  2,  8,  3,  3,  5,  5,  3,  2,  2,  2,  3,  4,  6,  6, # 0x40
     2,  5,  2,  8,  4,  4,  6,  6,  2,  4,  2,  7,  4,  4,  7,  7, # 0x50
     6,  6,  2,  8,  3,  3,  5,  5,  4,  2,  2,  2,  5,  4,  6,  6, # 0x60
     2,  5,  2,  8,  4,  4,  6,  6,  2,  4,  2,  7,  4,  4,  7,  7, # 0x70
     2,  6,  2,  6,  3,  3,  3,  3,  2,  2,  2,  2,  4,  4,  4,  4, # 0x80
     2,  6,  2,  6,  4,  4,  4,  4,  2,  5,  2,  5,  5,  5,  5,  5, # 0x90
     2,  6,  2,  6,  3,  3,  3,  3,  2,  2,  2,  2,  4,  4,  4,  4, # 0xA0
     2,  5,  2,  5,  4,  4,  4,  4,  2,  4,  2,  4,  4,  4,  4,  4, # 0xB0
     2,  6,  2,  8,  3,  3,  5,  5,  2,  2,  2,  2,  4,  4,  6,  6, # 0xC0
     2,  5,  2,  8,  4,  4,  6,  6,  2,  4,  2,  7,  4,  4,  7,  7, # 0xD0
     2,  6,  3,  8,  3,  3,  5,  5,  2,  2,  2,  2,  4,  4,  6,  6, # 0xE0
     2,  5,  2,  8,  4,  4,  6,  6,  2,  4,  2,  7,  4,  4,  7,  7  # 0xF0
  ]

  def [](inst, addr)
    @table[Table[inst][addr].first]
  end

  def table
    @table ||= Array.new(256, 0xFF)
  end

  def initialize
    Table.each do |(instruction, addresses)|
      addresses.each do |(address, (code, bytes, cycles))|

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

