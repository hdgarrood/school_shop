require 'match_method_macros'

class SizeConverter
  extend MatchMethodMacros

  #private
  def cm_to_inches(cm)
    0.39370087 * cm
  end

  def inches_to_cm(inches)
    2.54 * inches
  end

  def conversion_chart
    {
      :years => [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16],
      :height_cm => [98, 104, 110, 116, 122, 128, 134, 140, 146, 152, 158, 164, 170, 176],
      :chest_cm => [54, 56, 58, 61, 63, 66, 69, 72, 75, 78, 82, 86, 90, 96.5],
      :waist_cm => [52, 53.5, 55, 56, 57, 59, 61, 63.5, 66, 68, 70.5, 73, 76.5, 83],
      :collar_cm => [28, 28, 28, 29, 30, 30, 31, 32, 33, 34, 36, 37, 38, 40]
    }
  end

  # TODO: interpolation
  def convert_x_to_y(unit_from, unit_to, value)
    # convert inches to cm if necessary as we don't store inches data.
    if /inches/ =~ unit_from
      value = cm_to_inches(value)
      unit_from = unit_from.to_s.sub("inches", "cm").to_sym
    end

    if /inches/ =~ unit_to
      return_inches = true
      unit_to = unit_to.to_s.sub("inches", "cm").to_sym
    else
      return_inches = false
    end

    # get lists of values for both units in question
    values_from = conversion_chart[unit_from.to_sym]
    values_to = conversion_chart[unit_to.to_sym]

    # actually do the conversion here
    if value >= values_from.first && value <= values_from.last
      index_from = values_from.index { |elem| elem >= value }
      result = values_to[index_from]
      return_inches ? cm_to_inches(result) : result
    else
      nil
    end
  end

  # given "height_cm_to_years", returns [:height_cm, :years]
  def split_units(method)
    if (matchdata = method.to_s.match(/(.*)_to_(.*)/))
      unit_from = matchdata[1]
      unit_to = matchdata[2]
      [unit_from, unit_to].map { |a| a.to_sym }
    else
      [nil, nil]
    end
  end

  # regex for matching a conversion unit
  def self.unit
    "(years|height_cm|chest_cm|waist_cm|collar_cm|height_inches|chest_inches|waist_inches|collar_inches)"
  end

  public
  # defines all the methods years_to_height_cm, waist_cm_to_height_inches, etc
  match_method /\A#{unit}_to_#{unit}$/ do |name, value|
    unit_from, unit_to = split_units(name)
    convert_x_to_y(unit_from, unit_to, value)
  end
end
