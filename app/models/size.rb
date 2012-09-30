class Size
  include Comparable
  attr_reader :value, :unit

  class << self
    # all conversion stuff goes in here
    def convert(value, unit_from, unit_to)
      value_to = convert_value(value, unit_from, unit_to)
      value_to ? Size.new(value_to, unit_to) : nil
    end

    private
    CONVERSION_CHART = {
      "years" => [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16],
      "height_cm" => [98, 104, 110, 116, 122, 128, 134, 140, 146, 152, 158, 164, 170, 176],
      "chest_cm" => [54, 56, 58, 61, 63, 66, 69, 72, 75, 78, 82, 86, 90, 96.5],
      "waist_cm" => [52, 53.5, 55, 56, 57, 59, 61, 63.5, 66, 68, 70.5, 73, 76.5, 83],
      "collar_cm" => [28, 28, 28, 29, 30, 30, 31, 32, 33, 34, 36, 37, 38, 40],
      "height_inches" => [38.5, 41, 43.5, 45.5, 50.5, 52.75, 55, 57.5, 60, 62, 64.5, 67, 69.5],
      "chest_inches" => [21.25, 22, 22.75, 24, 24.75, 26, 27.25, 28.5, 29.5, 30.75, 32.25, 34, 35.5, 38],
      "waist_inches" => [20.5, 21, 21.75, 22, 22.5, 23.25, 24, 25, 26, 26.75, 27.75, 28.75, 29.75, 32.75],
      "collar_inches" => [11, 11, 11, 11.5, 11.75, 11.75, 12.25, 12.5, 13, 13.5, 14.25, 14.5, 15, 15.75]
    }

    def convert_value(value, unit_from, unit_to)
      # get lists of values for both units in question
      values_from = CONVERSION_CHART[unit_from]
      values_to = CONVERSION_CHART[unit_to]

      # are we in range?
      if value >= values_from.first && value <= values_from.last
        index_from = values_from.index { |elem| elem >= value }
        # do we need to interpolate?
        if value == values_from[index_from]
          values_to[index_from]
        else
          interpolate(value, index_from, values_from, values_to)
        end
      else
        # return nil if out of range
        nil
      end
    end

    def interpolate(value, index_from, values_from, values_to)
      ratio = (value - values_from[index_from]).to_f / (values_from[index_from+1] - values_from[index_from])
      difference = values_to[index_from+1] - values_to[index_from]
      (ratio * difference) + values_to[index_from]
    end
  end

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
      @value <=> other_size.convert_to(@unit).value
    end
  end

  def empty?
    @value.nil? && @unit.nil?
  end

  def to_s
    return "" if empty?

    unit_str = @unit.dup
    unit_str.gsub!('inches', '"')

    if unit_str.include?('_')
      "#{@value}#{unit_str.split('_')[1]}"
    else
      # unit is probably years
      "#{@value} #{unit_str}"
    end
  end
end
