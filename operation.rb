class Operation

  Table = {
    adc: {imm:     {code: 0x69, bytes: 2, cycles: 2},
          zp:      {code: 0x65, bytes: 2, cycles: 3},
          zpx:     {code: 0x75, bytes: 2, cycles: 4},
          abs:     {code: 0x6D, bytes: 3, cycles: 4},
          absx:    {code: 0x7D, bytes: 3, cycles: 4},
          absy:    {code: 0x79, bytes: 3, cycles: 4},
          preind:  {code: 0x61, bytes: 2, cycles: 6},
          postind: {code: 0x71, bytes: 2, cycles: 5}},
    and: {imm:     {code: 0x29, bytes: 2, cycles: 2},
          zp:      {code: 0x25, bytes: 2, cycles: 3},
          zpx:     {code: 0x35, bytes: 2, cycles: 4},
          abs:     {code: 0x2D, bytes: 3, cycles: 4},
          absx:    {code: 0x3D, bytes: 3, cycles: 4},
          absy:    {code: 0x39, bytes: 3, cycles: 4},
          preind:  {code: 0x21, bytes: 2, cycles: 6},
          postind: {code: 0x31, bytes: 2, cycles: 5}},
    asl: {acc:     {code: 0x0A, bytes: 1, cycles: 2},
          zp:      {code: 0x06, bytes: 2, cycles: 5},
          zpx:     {code: 0x16, bytes: 2, cycles: 6},
          abs:     {code: 0x0E, bytes: 3, cycles: 6},
          absx:    {code: 0x1E, bytes: 3, cycles: 7}},
    bcc: {rel:     {code: 0x90, bytes: 2, cycles: 2}},
    bcs: {rel:     {code: 0xB0, bytes: 2, cycles: 2}},
    beq: {rel:     {code: 0xF0, bytes: 2, cycles: 2}},
    bit: {zp:      {code: 0x24, bytes: 2, cycles: 3},
          abs:     {code: 0x2C, bytes: 3, cycles: 4}},
    bmi: {rel:     {code: 0x30, bytes: 2, cycles: 2}},
    bne: {rel:     {code: 0xD0, bytes: 2, cycles: 2}},
    bpl: {rel:     {code: 0x10, bytes: 2, cycles: 2}},
    brk: {imp:     {code: 0x00, bytes: 1, cycles: 7}},
    bvc: {rel:     {code: 0x50, bytes: 2, cycles: 2}},
    bvs: {rel:     {code: 0x70, bytes: 2, cycles: 2}},
    clc: {imp:     {code: 0x18, bytes: 1, cycles: 2}},
    cld: {imp:     {code: 0xD8, bytes: 1, cycles: 2}},
    cli: {imp:     {code: 0x58, bytes: 1, cycles: 2}},
    clv: {imp:     {code: 0xB8, bytes: 1, cycles: 2}},
    cmp: {imm:     {code: 0xC9, bytes: 2, cycles: 2},
          zp:      {code: 0xC5, bytes: 2, cycles: 3},
          zpx:     {code: 0xD5, bytes: 2, cycles: 4},
          abs:     {code: 0xCD, bytes: 3, cycles: 4},
          absx:    {code: 0xDD, bytes: 3, cycles: 4},
          absy:    {code: 0xD9, bytes: 3, cycles: 4},
          preind:  {code: 0xC1, bytes: 2, cycles: 6},
          postind: {code: 0xD1, bytes: 2, cycles: 5}},
    cpx: {imm:     {code: 0xE0, bytes: 2, cycles: 2},
          zp:      {code: 0xE4, bytes: 2, cycles: 3},
          abs:     {code: 0xEC, bytes: 3, cycles: 4}},
    cpy: {imm:     {code: 0xC0, bytes: 2, cycles: 2},
          zp:      {code: 0xC4, bytes: 2, cycles: 3},
          abs:     {code: 0xCC, bytes: 3, cycles: 4}},
    dec: {zp:      {code: 0xC6, bytes: 2, cycles: 5},
          zpx:     {code: 0xD6, bytes: 2, cycles: 6},
          abs:     {code: 0xCE, bytes: 3, cycles: 6},
          absx:    {code: 0xDE, bytes: 3, cycles: 7}},
    dex: {imp:     {code: 0xCA, bytes: 1, cycles: 2}},
    dey: {imp:     {code: 0x88, bytes: 1, cycles: 2}},
    eor: {imm:     {code: 0x49, bytes: 2, cycles: 2},
          zp:      {code: 0x45, bytes: 2, cycles: 3},
          zpx:     {code: 0x55, bytes: 2, cycles: 4},
          abs:     {code: 0x4D, bytes: 3, cycles: 4},
          absx:    {code: 0x5D, bytes: 3, cycles: 4},
          absy:    {code: 0x59, bytes: 3, cycles: 4},
          preind:  {code: 0x41, bytes: 2, cycles: 6},
          postind: {code: 0x51, bytes: 2, cycles: 5}},
    inc: {zp:      {code: 0xE6, bytes: 2, cycles: 5},
          zpx:     {code: 0xF6, bytes: 2, cycles: 6},
          abs:     {code: 0xEE, bytes: 3, cycles: 6},
          absx:    {code: 0xFE, bytes: 3, cycles: 7}},
    inx: {imp:     {code: 0xE8, bytes: 1, cycles: 2}},
    iny: {imp:     {code: 0xC8, bytes: 1, cycles: 2}},
    jmp: {abs:     {code: 0x4C, bytes: 3, cycles: 3},
          absind:  {code: 0x6C, bytes: 3, cycles: 5}},
    jsr: {abs:     {code: 0x20, bytes: 3, cycles: 6}},
    lda: {imm:     {code: 0xA9, bytes: 2, cycles: 2},
          zp:      {code: 0xA5, bytes: 2, cycles: 3},
          zpx:     {code: 0xB5, bytes: 2, cycles: 4},
          abs:     {code: 0xAD, bytes: 3, cycles: 4},
          absx:    {code: 0xBD, bytes: 3, cycles: 4},
          absy:    {code: 0xB9, bytes: 3, cycles: 4},
          preind:  {code: 0xA1, bytes: 2, cycles: 6},
          postind: {code: 0xB1, bytes: 2, cycles: 5}},
    ldx: {imm:     {code: 0xA2, bytes: 2, cycles: 2},
          zp:      {code: 0xA6, bytes: 2, cycles: 3},
          zpy:     {code: 0xB6, bytes: 2, cycles: 4},
          abs:     {code: 0xAE, bytes: 3, cycles: 4},
          absy:    {code: 0xBE, bytes: 3, cycles: 4}},
    ldy: {imm:     {code: 0xA0, bytes: 2, cycles: 2},
          zp:      {code: 0xA4, bytes: 2, cycles: 3},
          zpx:     {code: 0xB4, bytes: 2, cycles: 4},
          abs:     {code: 0xAC, bytes: 3, cycles: 4},
          absx:    {code: 0xBC, bytes: 3, cycles: 4}},
    lsr: {acc:     {code: 0x4A, bytes: 1, cycles: 2},
          zp:      {code: 0x46, bytes: 2, cycles: 5},
          zpx:     {code: 0x56, bytes: 2, cycles: 6},
          abs:     {code: 0x4E, bytes: 3, cycles: 6},
          absx:    {code: 0x5E, bytes: 3, cycles: 7}},
    nop: {imp:     {code: 0xEA, bytes: 1, cycles: 2}},
    ora: {imm:     {code: 0x09, bytes: 2, cycles: 2},
          zp:      {code: 0x05, bytes: 2, cycles: 3},
          zpx:     {code: 0x15, bytes: 2, cycles: 4},
          abs:     {code: 0x0D, bytes: 3, cycles: 4},
          absx:    {code: 0x1D, bytes: 3, cycles: 4},
          absy:    {code: 0x19, bytes: 3, cycles: 4},
          preind:  {code: 0x01, bytes: 2, cycles: 6},
          postind: {code: 0x11, bytes: 2, cycles: 5}},
    pha: {imp:     {code: 0x48, bytes: 1, cycles: 3}},
    php: {imp:     {code: 0x08, bytes: 1, cycles: 3}},
    pla: {imp:     {code: 0x68, bytes: 1, cycles: 4}},
    plp: {imp:     {code: 0x28, bytes: 1, cycles: 4}},
    rol: {acc:     {code: 0x2A, bytes: 1, cycles: 2},
          zp:      {code: 0x26, bytes: 2, cycles: 5},
          zpx:     {code: 0x36, bytes: 2, cycles: 6},
          abs:     {code: 0x2E, bytes: 3, cycles: 6},
          absx:    {code: 0x3E, bytes: 3, cycles: 7}},
    ror: {acc:     {code: 0x6A, bytes: 1, cycles: 2},
          zp:      {code: 0x66, bytes: 2, cycles: 5},
          zpx:     {code: 0x76, bytes: 2, cycles: 6},
          abs:     {code: 0x6E, bytes: 3, cycles: 6},
          absx:    {code: 0x7E, bytes: 3, cycles: 7}},
    rti: {imp:     {code: 0x40, bytes: 1, cycles: 6}},
    rts: {imp:     {code: 0x60, bytes: 1, cycles: 6}},
    sbc: {imm:     {code: 0xE9, bytes: 2, cycles: 2},
          zp:      {code: 0xE5, bytes: 2, cycles: 3},
          zpx:     {code: 0xF5, bytes: 2, cycles: 4},
          abs:     {code: 0xED, bytes: 3, cycles: 4},
          absx:    {code: 0xFD, bytes: 3, cycles: 4},
          absy:    {code: 0xF9, bytes: 3, cycles: 4},
          preind:  {code: 0xE1, bytes: 2, cycles: 6},
          postind: {code: 0xF1, bytes: 2, cycles: 5}},
    sec: {imp:     {code: 0x38, bytes: 1, cycles: 2}},
    sed: {imp:     {code: 0xF8, bytes: 1, cycles: 2}},
    sei: {imp:     {code: 0x78, bytes: 1, cycles: 2}},
    sta: {zp:      {code: 0x85, bytes: 2, cycles: 3},
          zpx:     {code: 0x95, bytes: 2, cycles: 4},
          abs:     {code: 0x8D, bytes: 3, cycles: 4},
          absx:    {code: 0x9D, bytes: 3, cycles: 5},
          absy:    {code: 0x99, bytes: 3, cycles: 5},
          preind:  {code: 0x81, bytes: 2, cycles: 6},
          postind: {code: 0x91, bytes: 2, cycles: 6}},
    stx: {zp:      {code: 0x86, bytes: 2, cycles: 3},
          zpy:     {code: 0x96, bytes: 2, cycles: 4},
          abs:     {code: 0x8E, bytes: 3, cycles: 4}},
    sty: {zp:      {code: 0x84, bytes: 2, cycles: 3},
          zpx:     {code: 0x94, bytes: 2, cycles: 4},
          abs:     {code: 0x8C, bytes: 3, cycles: 4}},
    tax: {imp:     {code: 0xAA, bytes: 1, cycles: 2}},
    tay: {imp:     {code: 0xA8, bytes: 1, cycles: 2}},
    tsx: {imp:     {code: 0xBA, bytes: 1, cycles: 2}},
    txa: {imp:     {code: 0x8A, bytes: 1, cycles: 2}},
    txs: {imp:     {code: 0x9A, bytes: 1, cycles: 2}},
    tya: {imp:     {code: 0x98, bytes: 1, cycles: 2}}
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
    table[Table[inst][addr][:code]]
  end

  def table
    @table ||= Array.new(256, 0xFF)
  end

  def initialize
    Table.each do |instruction, addresses|
      addresses.each do |address, attributes|

        table[attributes[:code]] =
          ((Instruction[:by_name][instruction] & 0xFF))       |
          ((Address[:by_name][address]         & 0xFF) << 8)  |
          ((attributes[:bytes]                 & 0xFF) << 16) |
          ((attributes[:cycles]                & 0xFF) << 24)

      end
    end
  end
end

