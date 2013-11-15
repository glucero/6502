class CPU

  def initialize
    @operation = Operation.new
    @register  = Register.new
    @status    = Status.new

    @status.brk =
    @status.na  =
    @status.int = 1

    @crash         =
    @irq_requested = false
  end

  def start
    @running = true
    # do stuff
  end

  def stop
    @running = false
    # stop stuff
  end

  def running?
    @running
  end

  def execute(code, address, cycle)
  end

  def status
    @status.value
  end

  def status=(status)
    @status.value = value
  end
end

