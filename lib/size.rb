require 'size_converter'

class Size
  extend SizeConverter
  include Comparable
  attr_reader :value, :unit

  def initialize(value, unit = "inches")
    @value, @unit = value, unit
  end
end
