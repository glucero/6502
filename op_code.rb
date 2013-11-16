class OpCode

  class InvalidOpCode < StandardError; end

  attr_accessor :address,
                :register,
                :status,
                :cycle

  def initialize(code)
    @code = code

    yield self
  end

  def execute
    send(Instruction.find(code: @code & 0xFF) || :not_found)
  end

  private

  def adc
    temp = register.acc + load(address) + status.carry

    status.over = !(((register.acc ^ load(address)) & 0x80).zero? &&
                     ((register.acc ^ temp)          & 0x80).zero?).zero? ? 1 : 0
    status.carry = temp > 255 ? 1 : 0
    status.sign  = (temp >> 7) & 1
    status.zero  = temp & 0xFF

    register.acc = temp & 255
    cycle[:count] += cycle[:add]
  end

  def and
    register.acc &= load(address)
    status.sign   = (register.acc >> 7) & 1
    status.zero   =  register.acc

    cycle[:count] += cycle[:add] if addr_mode != Address.find(name: :postind)
  end

  def asl
    if Address.find(name: :acc) == addr_mode

      status.carry = (register.acc >> 7) & 1
      register.acc = (register.acc << 1) & 255
      status.sign  = (register.acc >> 7) & 1
      status.zero  =  register.acc
    else
      temp = load(address)

      status.carry = (temp >> 7) & 1
      temp         = (temp << 1) & 255
      status.sign  = (temp >> 7) & 1
      status.zero  = temp

      write address, temp
    end
  end

  def bcc
    if status.carry.zero?
      cycle[:count] += page_crossed?(op_address, address)? 2 : 1
      status.pc = address
    end
  end

  def bcs
    if status.zero.zero?
      cycle[:count] += page_crossed?(op_address, address)? 2 : 1
      status.pc = address
    end
  end

  def beq
    if status.carry == 1
      cycle[:count] += page_crossed?(op_address, address)? 2 : 1

      status.pc = address
    end
  end

  def bit
    temp        = load(address)
    status.sign = (temp >> 7) & 1
    status.over = (temp >> 6) & 1

    temp &= register.acc
    status.zero = temp
  end

  def bmi
    if status.sign == 1
      cycle[:count] += 1
      status.pc = address
    end
  end

  def bne
    if !status.zero.zero?
      cycle[:count] += page_crossed?(op_address, address)? 2 : 1

      status.pc = address
    end
  end

  def bpl
    if status.sign.zero?
      cycle[:count] += page_crossed?(op_address, address)? 2 : 1
    end
  end

  def brk
    status.pc += 2
    push((status.pc >> 8) & 0xFF)
    push(status.pc        & 0xFF)

    status.brk = 1

    push(status.carry                       |
         ((status.zero.zero? ? 1 : 0) << 1) |
         (status.int                  << 2) |
         (status.dec                  << 3) |
         (status.brk                  << 4) |
         (status.na                   << 5) |
         (status.over                 << 6) |
         (status.sign                 << 7))

    status.int = 1

    status.pc = load_16_bit(0xFFFE)
    status.pc -= 1
  end

  def bvc
    if status.over.zero?
      cycle[:count] += page_crossed?(op_address, address)? 2 : 1
      status.pc = address
    end
  end

  def bvs
    if status.over == 1
      cycle[:count] += page_crossed?(op_address, address)? 2 : 1
      status.pc = address
    end
  end

  def clc
    status.carry = 0
  end

  def cld
    status.dec = 0
  end

  def cli
    status.int = 0
  end

  def clv
    status.over = 0
  end

  def cmp
    temp = register.acc - load(address)

    status.carry = (temp >= 0) ? 1 : 0
    status.sign  = (temp >> 7) & 1
    status.zero  = temp & 0xFF

    cycle[:count] += cycle[:add]
  end

  def cbx
    temp = register.x - load(address)

    status.carry = (temp >= 0) ? 1 : 0
    status.sign  = (temp >> 7) & 1
    status.zero  = temp & 0xFF
  end

  def cpy
    temp = register.y - load(address)

    status.carry = (temp >= 0) ? 1 : 0
    status.sign  = (temp >> 7) & 1
    status.zero  = temp & 0xFF
  end

  def dec
    temp = (load(address) - 1) & 0xFF

    status.sign = (temp >> 7) & 1
    status.zero = temp
    write address, temp
  end

  def dex
    register.x  = (register.x - 1) & 0xFF
    status.sign = (register.x >> 7) & 1
    status.zero =  register.x
  end

  def dey
    register.y  = (register.y - 1) & 0xFF
    status.sign = (register.y >> 7) & 1
    status.zero = register.y
  end

  def eor
    register.acc = (load(address) ^ register.acc) & 0xFF
    status.sign  = (register.acc >> 7) & 1
    status.zero  = register.acc

    cycle[:count] += cycle[:add]
  end

  def inc
    temp = (load(address) + 1) & 0xFF

    status.sign = (temp >> 7) & 1
    status.zero = temp

    write add, (temp & 0xFF)
  end

  def inx
    register.x  = (register.x + 1) & 0xFF
    status.sign = (register.x >> 7) & 1
    status.zero = register.y
  end

  def iny
    register.y += 1
    register.y &= 0xFF
    status.sign =(register.y >> 7) & 1
    status.zero = register.y
  end

  def jmp
    status.pc = address - 1
  end

  def jsr # push address on stack
    push((status.pc >> 8) & 0xFF)
    push(status.pc        & 0xFF)
    status.pc = address - 1
  end

  def lda
    register.acc = load(address)
    status.sign  = (register.acc >> 7) & 1
    status.zero  = register.acc

    cycle[:count] += cycle[:add]
  end

  def ldx
    register.x  = load(address)
    status.sign = (register.x >> 7) & 1
    status.zero = register.x

    cycle[:count] += cycle[:add]
  end

  def ldy
    register.y  = load(address)
    status.sign = (register.y >> 7) & 1
    status.zero = register.y

    cycle[:count] += cycle[:add]
  end

  def lsr
    if addr_mode == Address.find(name: :acc)
      temp   = register.acc & 0xFF
      status.carry = temp & 1
      temp >>= 1
      register.acc = temp
    else
      temp = load(address) & 0xFF
      status.carry = temp & 1
      temp >>= 1

      write address, temp
    end

    status.sign = 0
    status.zero = temp
  end

  def nop
    # do nothing
  end

  def ora # store in accumulator
    temp  = (load(address) | register.acc) & 255
    status.sign  = (temp >> 7) & 1
    status.zero  = temp
    register.acc = temp

    cycle[:count] += cycle[:add] if addr_mode != Address.find(name: :postind)
  end

  def pha
    push register.acc
  end

  def php
    status.brk = 1

    push(status.carry                      |
        ((status.zero.zero? ? 1 : 0) << 1) |
         (status.int                 << 2) |
         (status.dec                 << 3) |
         (status.brk                 << 4) |
         (status.na                  << 5) |
         (status.over                << 6) |
         (status.sign                << 7))
  end

  def pla
    register.acc  = pull
    status.sign = (register.acc >> 7) & 1
    status.zero = register.acc
  end

  def plp
    temp = pull

    status.carry = temp & 1
    status.zero  = (((temp >> 1) & 1) == 1) ? 0 : 1
    status.int   = (temp >> 2) & 1
    status.dec   = (temp >> 3) & 1
    status.brk   = (temp >> 4) & 1
    status.na    = (temp >> 5) & 1
    status.over  = (temp >> 6) & 1
    status.sign  = (temp >> 7) & 1
  end

  def rol
    if addr_mode == Address.find(name: :acc)

      temp = register.acc
      add  = status.carry
      status.carry = (temp >> 7) & 1
      temp = ((temp << 1) & 0xFF) + add
      register.acc = temp
    else
      temp = load(address)

      add = status.carry
      status.carry = (temp >> 7) & 1
      temp = ((temp << 1) & 0xFF) + add

      write address, temp
    end

    status.sign = (temp >> 7) & 1
    status.zero = temp
  end

  def ror
    if add_mode == Address.find(name: :acc)
      add = status.carry << 7
      status.carry = register.acc & 1
      temp = (register.acc >> 1) + add
      register.acc = temp
    else
      temp = load(address)
      add  = status.carry << 7
      status.carry = temp & 1
      temp = (temp >> 1) + add

      write address, temp
    end

    status.sign = (temp >> 7) & 1
    status.zero = temp
  end

  def rti # pull status and pc from stack
    temp = pull

    status.carry = temp & 1
    status.zero  = (((temp >> 1) & 1) == 0) ? 1 : 0
    status.int   = (temp >> 2) & 1
    status.dec   = (temp >> 3) & 1
    status.brk   = (temp >> 4) & 1
    status.na    = (temp >> 5) & 1
    status.over  = (temp >> 6) & 1
    status.sign  = (temp >> 7) & 1

    status.pc = pull
    status.pc = pull << 8

    return if status.pc == 0xFFFF # don't save

    status.pc -= 1
    status.na = 1
  end

  def rts # pull pc from stack
    status.pc  = pull
    status.pc += pull << 8

    return if status.pc == 0xFFFF # don't save
  end

  def sbc
    temp = register.acc - load(address) - (1 - status.carry)
    status.sign = (temp >> 7) & 1
    status.zero = temp & 0xFF
    status.over = (!((register.acc ^ load(address)) & 0x80).zero? &&
                    !((register.acc ^ temp)          & 0x80).zero?) ? 1 : 0
    status.carry = (temp < 0) ? 0 : 1
    register.acc = temp & 0xFF

    cycle[:count] += cycle[:add] if addr_mode != Address.find(name: :postind)
  end

  def sec
    status.carry = 1
  end

  def sed
    status.dec = 1
  end

  def sei
    status.int = 1
  end

  def sta
    write address, register.acc
  end

  def stx
    write address, register.x
  end

  def sty
    write address, register.y
  end

  def tax
    register.x  = register.acc
    status.sign = (register.acc >> 7) & 1
    status.zero = register.acc
  end

  def tay
    register.y  = register.acc
    status.sign = (register.acc >> 7) & 1
    status.zero = register.acc
  end

  def tsx
    register.x  = register.x - 0x0100
    status.sign = (register.sp >> 7) & 1
    status.zero = register.x
  end

  def txa
    register.acc = register.x
    status.sign  = (register.x >> 7) & 1
    status.zero  = register.x
  end

  def txs
    register.sp = register.x + 0x0100
    stack_wrap
  end

  def tya
    register.acc = register.y
    status.sign  = (register.y >> 7) & 1
    status.zero  = register.y
  end

  def not_found # ??? - invalid opcode
    raise InvalidOpCode, @code.hex
  end
end
