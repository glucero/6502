class Fixnum

  def hex
    "0x#{'%02X' % self}"
  end
end
