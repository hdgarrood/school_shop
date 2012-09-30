require 'size/size'

class SizeRange
  attr_reader :lbound, :ubound, :unit

  class << self
    def from_size(size)
      new(size.value, size.value, size.unit)
    end
  end

  def initialize(lbound, ubound, unit)
    @lbound = lbound
    @ubound = ubound
    @unit = unit
  end

  def convert_to(other_unit)
    other_lbound = Size.convert(@lbound, @unit, other_unit).value
    other_ubound = Size.convert(@lbound, @unit. other_unit).value
    SizeRange.new(other_lbound, other_ubound, other_unit)
  end

  def empty?
    @lbound.nil? && @ubound.nil? && @unit.nil?
  end

  # returns true if this SizeRange's range is greater than 0. If this
  # returns false, we can treat this SizeRange object like a Size.
  def has_range?
    @lbound != @ubound
  end

  # convert this SizeRange to a normal size if @ubound == @lbound
  # returns nil if can't convert to size
  def to_size
    has_range? ? nil : Size.new(@lbound, @unit)
  end

  def to_s
    # if all attributes are nil, return ""
    return "" if empty?
    return to_size.to_s unless has_range?

    unit_str = @unit.sub('inches', '"')
    if unit_str.include?('_')
      "#{@lbound}-#{@ubound}#{unit_str.split('_')[1]}"
    else
      "#{@lbound}-#{@ubound} #{unit_str}"
    end
  end
end
