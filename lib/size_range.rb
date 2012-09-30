require 'size'

class SizeRange
  attr_reader :lbound, :ubound

  def initialize(lbound, ubound = nil, unit)
    @lbound = Size.new(lbound, unit)
    @ubound = ubound ? Size.new(ubound, unit) : @lbound
  end

  def unit
    @lbound.unit
  end
end
