Instruction = { #|   The 6502 microprocessor instruction set:
  by_code: [
  # The following notation applies to this summary:
  #
  #    A       Accumulator                  EOR     Logical Exclusive Or
  #    X, Y    Index Registers              fromS   Transfer from Stack
  #    M       Memory                       toS     Transfer to Stack
  #    P       Processor Status Register    ->      Transfer to
  #    S       Stack Pointer                <-      Transfer from
  #    /       Change                       ||       Logical OR
  #    _       No Change                    PC      Program Counter
  #    +       Add                          PCH     Program Counter High
  #    &&      Logical AND                  PCL     Program Counter Low
  #    -       Subtract                     OPER    OPERAND
  #                                         #       IMMEDIATE ADDRESSING MODE

    :adc, # add memory to accumulator with carry
    #  Operation:  A + M + C -> A, C                         N Z C I D V
    #                                                        / / / _ _ /
    #  +----------------+-----------------------+---------+---------+----------+
    #  | Addressing Mode| Assembly Language Form| OP CODE |No. Bytes|No. Cycles|
    #  +----------------+-----------------------+---------+---------+----------+
    #  |  Immediate     |   ADC #Oper           |    69   |    2    |    2     |
    #  |  Zero Page     |   ADC Oper            |    65   |    2    |    3     |
    #  |  Zero Page,X   |   ADC Oper,X          |    75   |    2    |    4     |
    #  |  Absolute      |   ADC Oper            |    60   |    3    |    4     |
    #  |  Absolute,X    |   ADC Oper,X          |    70   |    3    |    4*    |
    #  |  Absolute,Y    |   ADC Oper,Y          |    79   |    3    |    4*    |
    #  |  (Indirect,X)  |   ADC (Oper,X)        |    61   |    2    |    6     |
    #  |  (Indirect),Y  |   ADC (Oper),Y        |    71   |    2    |    5*    |
    #  +----------------+-----------------------+---------+---------+----------+
    #  * Add 1 if page boundary is crossed.

    :and, # 'and' memory with accumulator
    #  Operation:  A && M -> A                               N Z C I D V
    #                                                        / / _ _ _ _
    #  +----------------+-----------------------+---------+---------+----------+
    #  | Addressing Mode| Assembly Language Form| OP CODE |No. Bytes|No. Cycles|
    #  +----------------+-----------------------+---------+---------+----------+
    #  |  Immediate     |   AND #Oper           |    29   |    2    |    2     |
    #  |  Zero Page     |   AND Oper            |    25   |    2    |    3     |
    #  |  Zero Page,X   |   AND Oper,X          |    35   |    2    |    4     |
    #  |  Absolute      |   AND Oper            |    2D   |    3    |    4     |
    #  |  Absolute,X    |   AND Oper,X          |    3D   |    3    |    4*    |
    #  |  Absolute,Y    |   AND Oper,Y          |    39   |    3    |    4*    |
    #  |  (Indirect,X)  |   AND (Oper,X)        |    21   |    2    |    6     |
    #  |  (Indirect,Y)  |   AND (Oper),Y        |    31   |    2    |    5     |
    #  +----------------+-----------------------+---------+---------+----------+
    #  * Add 1 if page boundary is crossed.

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
}.tap do |instruction|
  instruction[:by_name] = Hash[instruction[:by_code].zip 0...instruction[:by_code].count]
end

