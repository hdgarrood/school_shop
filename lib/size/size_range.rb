require 'size/size'

class SizeRange
  attr_reader :lbound, :ubound, :unit

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
    @lbound.nil? && @unit.nil?
  end

  # convert this SizeRange to a normal size if @ubound is nil
  # returns nil if 
  def to_size
    @ubound ? nil : Size.new(@lbound, @unit)
  end

  def to_s
    # if all attributes are nil, return ""
    return "" if empty?
    # if no upper bound, behave like a Size
    return to_size.to_s if @ubound.nil?

    unit_str = @unit.sub('inches', '"')
    if unit_str.include?('_')
      "#{@lbound}-#{@ubound}#{unit_str.split('_')[1]}"
    else
      "#{@lbound}-#{@ubound} #{unit_str}"
    end
  end
end
