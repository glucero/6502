Status = Struct.new(

# Status consists of eight bit flags to indicate whether something has, or
# has not occurred.  Bits of this register are altered depending on the
# result of arithmetic and logical operations. The most commonly used flags
# are :carry, :zero, :over and :sign.

  :carry, # This holds the carry out of the most significant bit in any
  # arithmetic operation. In subtraction operations however, this flag is
  # cleared - set to 0 - if a borrow is required, set to 1 - if no borrow is
  # required. The carry flag is also used in shift and rotate logical
  # operations.

  :zero, # This is set to 1 when any arithmetic or logical operation produces
  # a zero result, and is set to 0 if the result is non-zero.

  :int, # (interrupt) This is an interrupt enable/disable flag. If it is set,
  # interrupts are disabled. If it is cleared, interrupts are enabled.

  :dec, # (decimal )This is the decimal mode status flag. When set, and an Add with
  # Carry or Subtract with Carry instruction is executed, the source values
  # are treated as valid BCD (Binary Coded Decimal, eg. 0x00-0x99 = 0-99)
  # numbers. The result generated is also a BCD number.

  :brk, # (break) This is set when a software interrupt (BRK) is executed.

  :na, # (not used) Not used and is supposed to be logical 1 at all times.

  :over, # (overflow) When an arithmetic operation produces a result too large to be
  # represented in a byte, V is set.

  :sign # This is set if the result of an operation is negative, cleared if
  # positive.
  ) do

  def reset
    carry =
    dec   =
    over  =
    sign  =
    zero  = 0

    int =
    na  =
    brk = 1
  end

  def value
    (carry    ) |
    (zero << 1) |
    (int  << 2) |
    (dec  << 3) |
    (brk  << 4) |
    (na   << 5) |
    (over << 6) |
    (sign << 7)
  end

  def value=(value)
    carry = (value     ) & 1
    zero  = (value >> 1) & 1
    int   = (value >> 2) & 1
    dec   = (value >> 3) & 1
    brk   = (value >> 4) & 1
    na    = (value >> 5) & 1
    over  = (value >> 6) & 1
    sign  = (value >> 7) & 1
  end

  def self.init
    new *[FLUSH]*8
  end
end

