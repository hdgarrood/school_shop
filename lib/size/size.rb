require 'size/size_converter'

class Size
  extend SizeConverter
  include Comparable
  attr_reader :value, :unit

  def initialize(value, unit)
    @value, @unit = value, unit
  end

  def convert_to(other_unit)
    Size.convert(@value, @unit, other_unit)
  end

  def ==(other_size)
    @value == other_size.value && @unit == other_size.unit
  end

  def <=>(other_size)
    if @unit == other_size.unit
      @value <=> other_size.value
    else
      @value <=> other_size.convert_to(@unit)
    end
  end

  def to_s
    unit_str = @unit.dup
    unit_str.gsub!('inches', '"')

    if unit_str.include?('_')
      # eg height_cm
      measurement, unit_name = unit_str.split('_')
      "#{@value}#{unit_name} (#{measurement})"
    else
      # unit is probably years
      "#{@value} #{unit_str}"
    end
  end
end
