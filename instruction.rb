class Instruction

  class InvalidInstructionCode < StandardError; end
  class InvalidInstructionName < StandardError; end
  class InvalidInstructionType < StandardError; end

  TABLE = [ # The 6502 microprocessor instruction set:

    :adc, # add memory to accumulator with carry
    :and, # 'and' memory with accumulator
    :asl, # shift left one bit (memory or accumulator)
    :bcc, # branch on carry clear
    :bcs, # branch on carry set
    :beq, # branch on result zero
    :bit, # test bits in memory with accumulator
    :bmi, # branch on result minus
    :bne, # branch on result not zero
    :bpl, # branch on result plus
    :brk, # force break
    :bvc, # branch on overflow clear
    :bvs, # branch on overflow set
    :clc, # clear carry flag
    :cld, # clear decimal mode flag
    :cli, # clear interrupt disable flag
    :clv, # clear overflow flag
    :cmp, # compare memory and accumulator
    :cpx, # compare memory and index x
    :cpy, # compare memory and index y
    :dec, # decrement memory by one
    :dex, # decrement index x by one
    :dey, # decrement index y by one
    :eor, # 'exclusive-or' memory with accumulator
    :inc, # increment memory by one
    :inx, # increment index x by one
    :iny, # increment index y by one
    :jmp, # jump to new location
    :jsr, # jump to new location saving return address
    :lda, # load accumulator with memory
    :ldx, # load index x with memory
    :ldy, # load index y with memory
    :lsr, # shift right one bit (memory or accumulator)
    :nop, # no operation
    :ora, # 'or' memory with accumulator
    :pha, # push accumulator on stack
    :php, # push processor status on stack
    :pla, # pull accumulator from stack
    :plp, # pull processor status from_stack
    :rol, # rotate one bit left (memory or accumulator)
    :ror, # rotate one bit right (memory or accumulator)
    :rti, # return from interrupt
    :rts, # return from subroutine
    :sbc, # subtract memory from accumulator with borrow
    :sec, # set carry flag
    :sed, # set decimal mode flag
    :sei, # set interrupt disable status flag
    :sta, # store accumulator in memory
    :stx, # store index x in memory
    :sty, # store index y in memory
    :tax, # transfer accumulator to index x
    :tay, # transfer accumulator to index y
    :tsx, # transfer stack pointer to index x
    :txa, # transfer index x to accumlator
    :txs, # transfer index x to stack pointer
    :tya  # transfer index y to accumulator
  ]

  class << self
    def code(value)
      TABLE[value] || raise
    rescue Exception
      raise InvalidInstructionCode, value
    end

    def name(value)
      TABLE.index(value) || raise
    rescue Exception
      raise InvalidInstructionName, value
    end

    def find(**options)
      type, value = options.shift

      if type && value && respond_to?(type)
        send type, value
      else
        raise InvalidInstructionType, type
      end
    end
  end
end

