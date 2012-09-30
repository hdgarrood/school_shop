require 'size/size'

class SizeRange
  attr_reader :lbound, :ubound

  def initialize(lbound, ubound = nil, unit)
    @lbound = Size.new(lbound, unit)
    @ubound = ubound ? Size.new(ubound, unit) : @lbound
  end

  def unit
    @lbound.unit
  end

  def convert_to(other_unit)
    other_lbound = @lbound.convert_to(other_unit)
    other_ubound = @ubound.convert_to(other_unit)
    SizeRange.new(other_lbound, other_ubound, other_unit)
  end

  def to_s
    unit_str = unit
    unit_str.gsub!('inches', '"')

    if unit_str.include?('_')
      measurement, unit_name = unit_str.split('_')
      "#{@lbound.value}#{unit_name} - #{@ubound.value}#{unit_name} (#{measurement})"
    else
      "#{@lbound.value} - #{@ubound.value} #{unit_str}"
    end
  end
end
