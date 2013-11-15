class Command

  class InvalidOpCode < StandardError; end

  def initialize(code, address)
    @code, @address = code, address
  end

  def execute(register, status, cycle)
    send Instruction[:by_code].fetch(code & 0xFF, :not_found), register, status, cycle
  end

  private

  def adc(register, status, cycle)
    temp = register.acc + load(address) + status.carry

    status.over = !(((register.acc ^ load(address)) & 0x80).zero? &&
                     ((register.acc ^ temp)          & 0x80).zero?).zero? ? 1 : 0
    status.carry = temp > 255 ? 1 : 0
    status.sign  = (temp >> 7) & 1
    status.zero  = temp & 0xFF

    register.acc = temp & 255
    cycle[:count] += cycle[:add]
  end

  def and(register, status, cycle)
    register.acc &= load(address)
    status.sign   = (register.acc >> 7) & 1
    status.zero   =  register.acc

    cycle[:count] += cycle[:add] if addr_mode != Address[:by_name][:postind]
  end

  def asl(register, status, cycle)
    if Address[:by_name][:acc] == addr_mode

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

  def bcc(register, status, cycle)
    if status.carry.zero?
      cycle[:count] += page_crossed?(op_address, address)? 2 : 1
      status.pc = address
    end
  end

  def bcs(register, status, cycle)
    if status.zero.zero?
      cycle[:count] += page_crossed?(op_address, address)? 2 : 1
      status.pc = address
    end
  end

  def beq(register, status, cycle)
    if status.carry == 1
      cycle[:count] += page_crossed?(op_address, address)? 2 : 1

      status.pc = address
    end
  end

  def bit(register, status, cycle)
    temp        = load(address)
    status.sign = (temp >> 7) & 1
    status.over = (temp >> 6) & 1

    temp &= register.acc
    status.zero = temp
  end

  def bmi(register, status, cycle)
    if status.sign == 1
      cycle[:count] += 1
      status.pc = address
    end
  end

  def bne(register, status, cycle)
    if !status.zero.zero?
      cycle[:count] += page_crossed?(op_address, address)? 2 : 1

      status.pc = address
    end
  end

  def bpl(register, status, cycle)
    if status.sign.zero?
      cycle[:count] += page_crossed?(op_address, address)? 2 : 1
    end
  end

  def brk(register, status, cycle)
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

  def bvc(register, status, cycle)
    if status.over.zero?
      cycle[:count] += page_crossed?(op_address, address)? 2 : 1
      status.pc = address
    end
  end

  def bvs(register, status, cycle)
    if status.over == 1
      cycle[:count] += page_crossed?(op_address, address)? 2 : 1
      status.pc = address
    end
  end

  def clc(register, status, cycle)
    status.carry = 0
  end

  def cld(register, status, cycle)
    status.dec = 0
  end

  def cli(register, status, cycle)
    status.int = 0
  end

  def clv(register, status, cycle)
    status.over = 0
  end

  def cmp(register, status, cycle)
    temp = register.acc - load(address)

    status.carry = (temp >= 0) ? 1 : 0
    status.sign  = (temp >> 7) & 1
    status.zero  = temp & 0xFF

    cycle[:count] += cycle[:add]
  end

  def cbx(register, status, cycle)
    temp = register.x - load(address)

    status.carry = (temp >= 0) ? 1 : 0
    status.sign  = (temp >> 7) & 1
    status.zero  = temp & 0xFF
  end

  def cpy(register, status, cycle)
    temp = register.y - load(address)

    status.carry = (temp >= 0) ? 1 : 0
    status.sign  = (temp >> 7) & 1
    status.zero  = temp & 0xFF
  end

  def dec(register, status, cycle)
    temp = (load(address) - 1) & 0xFF

    status.sign = (temp >> 7) & 1
    status.zero = temp
    write address, temp
  end

  def dex(register, status, cycle)
    register.x  = (register.x - 1) & 0xFF
    status.sign = (register.x >> 7) & 1
    status.zero =  register.x
  end

  def dey(register, status, cycle)
    register.y  = (register.y - 1) & 0xFF
    status.sign = (register.y >> 7) & 1
    status.zero = register.y
  end

  def eor(register, status, cycle)
    register.acc = (load(address) ^ register.acc) & 0xFF
    status.sign  = (register.acc >> 7) & 1
    status.zero  = register.acc

    cycle[:count] += cycle[:add]
  end

  def inc(register, status, cycle)
    temp = (load(address) + 1) & 0xFF

    status.sign = (temp >> 7) & 1
    status.zero = temp

    write add, (temp & 0xFF)
  end

  def inx(register, status, cycle)
    register.x  = (register.x + 1) & 0xFF
    status.sign = (register.x >> 7) & 1
    status.zero = register.y
  end

  def iny(register, status, cycle)
    register.y += 1
    register.y &= 0xFF
    status.sign =(register.y >> 7) & 1
    status.zero = register.y
  end

  def jmp(register, status, cycle)
    status.pc = address - 1
  end

  def jsr(register, status, cycle) # push address on stack
    push((status.pc >> 8) & 0xFF)
    push(status.pc        & 0xFF)
    status.pc = address - 1
  end

  def lda(register, status, cycle)
    register.acc = load(address)
    status.sign  = (register.acc >> 7) & 1
    status.zero  = register.acc

    cycle[:count] += cycle[:add]
  end

  def ldx(register, status, cycle)
    register.x  = load(address)
    status.sign = (register.x >> 7) & 1
    status.zero = register.x

    cycle[:count] += cycle[:add]
  end

  def ldy(register, status, cycle)
    register.y  = load(address)
    status.sign = (register.y >> 7) & 1
    status.zero = register.y

    cycle[:count] += cycle[:add]
  end

  def lsr(register, status, cycle)
    if addr_mode == Address[:by_name][:acc]
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

  def nop(register, status, cycle)
    # do nothing
  end

  def ora(register, status, cycle) # store in accumulator
    temp  = (load(address) | register.acc) & 255
    status.sign  = (temp >> 7) & 1
    status.zero  = temp
    register.acc = temp

    cycle[:count] += cycle[:add] if addr_mode != Address[:by_name][:postind]
  end

  def pha(register, status, cycle)
    push register.acc
  end

  def php(register, status, cycle)
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

  def pla(register, status, cycle)
    register.acc  = pull
    status.sign = (register.acc >> 7) & 1
    status.zero = register.acc
  end

  def plp(register, status, cycle)
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

  def rol(register, status, cycle)
    if addr_mode == Address[:by_name][:acc]

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

  def ror(register, status, cycle)
    if add_mode == Address[:by_name][:acc]
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

  def rti(register, status, cycle) # pull status and pc from stack
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

  def rts(register, status, cycle) # pull pc from stack
    status.pc  = pull
    status.pc += pull << 8

    return if status.pc == 0xFFFF # don't save
  end

  def sbc(register, status, cycle)
    temp = register.acc - load(address) - (1 - status.carry)
    status.sign = (temp >> 7) & 1
    status.zero = temp & 0xFF
    status.over = (!((register.acc ^ load(address)) & 0x80).zero? &&
                    !((register.acc ^ temp)          & 0x80).zero?) ? 1 : 0
    status.carry = (temp < 0) ? 0 : 1
    register.acc = temp & 0xFF

    cycle[:count] += cycle[:add] if addr_mode != Address[:by_name][:postind]
  end

  def sec(register, status, cycle)
    status.carry = 1
  end

  def sed(register, status, cycle)
    status.dec = 1
  end

  def sei(register, status, cycle)
    status.int = 1
  end

  def sta(register, status, cycle)
    write address, register.acc
  end

  def stx(register, status, cycle)
    write address, register.x
  end

  def sty(register, status, cycle)
    write address, register.y
  end

  def tax(register, status, cycle)
    register.x  = register.acc
    status.sign = (register.acc >> 7) & 1
    status.zero = register.acc
  end

  def tay(register, status, cycle)
    register.y  = register.acc
    status.sign = (register.acc >> 7) & 1
    status.zero = register.acc
  end

  def tsx(register, status, cycle)
    register.x  = register.x - 0x0100
    status.sign = (register.sp >> 7) & 1
    status.zero = register.x
  end

  def txa(register, status, cycle)
    register.acc = register.x
    status.sign  = (register.x >> 7) & 1
    status.zero  = register.x
  end

  def txs(register, status, cycle)
    register.sp = register.x + 0x0100
    stack_wrap
  end

  def tya(register, status, cycle)
    register.acc = register.y
    status.sign  = (register.y >> 7) & 1
    status.zero  = register.y
  end

  def not_found(register, status, cycle) # ??? - illegal opcode
    raise InvalidOpCode, "at address #{@code.hex}"
  end
end
