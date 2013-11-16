Register = Struct.new(

# Almost all calculations are done in the microprocessor.
# Registers are special pieces of memory in the processor which are used to
# carry out, and store information about calculations. The 6502 has the
# following registers:

  :acc, # (accumulator) This is THE most important register in the
  # microprocessor. Various machine language instructions allow you to copy
  # the contents of a memory location into the accumulator, copy the contents
  # of the accumulator into a memory location, modify the contents of the
  # accumulator or some other register directly, without affecting any
  # memory. And the accumulator is the only register that has instructions
  # for performing math.

  :x, :y, # These are very important registers. There are instructions for
  # nearly all of the transformations you can make to the accumulator. But
  # there are other instructions for things that only each register can do.
  # Various machine language instructions allow you to copy the contents of a
  # memory location into these registers, copy the contents of the register
  # into a memory location, and modify the contents of the register, or some
  # other register directly.

  :stat, # (status) These bits are described under Status.

  :pc, # (program counter) This contains the address of the current
  # machine language instruction being executed. Since the operating system
  # is always "RUN"ning, the program counter is always changing. It could
  # be stopped by halting the microprocessor in some way.

  :sp # (stack pointer) This register contains the location of the first
  # empty place on the stack. The stack is used for temporary storage by
  # machine language programs, and by the computer.
  ) do

  def set(value)
    acc  =
    x    =
    y    =
    stat =
    pc   =
    sp   = value
  end

  def self.init
    new *[FLUSH]*6
  end
end

