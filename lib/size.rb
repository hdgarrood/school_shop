require 'size_converter'

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
end
