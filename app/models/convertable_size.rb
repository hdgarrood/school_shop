# Like a size, but also has a measurement (height, weight, chest, collar)
# which means it can be converted between years and cm/inches.
class ConvertableSize < Size
  extend SizeConverter
  has_fields :measurement
  validates :measurement, :inclusion => { :in => %w(height weight chest collar) }

  def convert_to(new_unit)
    new_lbound = convert_bound(@lbound, new_unit)
    new_ubound = convert_bound(@ubound, new_unit)
    ConvertableSize.new(new_lbound, new_ubound, @unit, new_unit)
  end

  def to_size
    Size.new(@lbound, @ubound, @unit)
  end

  def to_s
    # if all attributes are nil, return ""
    return "" if empty?

    unit_str = @unit == 'inches' ? '"' : @unit
    lbound_str, ubound_str = bounds_to_strings

    lbound_str == ubound_str ?
      "#{lbound_str}#{space_or_empty}#{unit_str}" :
      "#{lbound_str}-#{ubound_str}#{space_or_empty}#{unit_str}"
  end

  private
  def convert_bound(bound, new_unit)
    ConvertableSize.convert(bound, @measurement, @unit, new_unit)
  end

  # returns a space or an empty string, depending on attributes
  # used in #to_s
  def space_or_empty
    unit == 'years' ? ' ' : ''
  end

  def rounding_mode
    if @unit == 'inches'
      :to_nearest_quarter
    elsif @unit == 'cm' && @measurement == 'waist'
      :to_nearest_half
    else
      :to_nearest_whole
    end
  end

  # converts lbound and ubound to strings for display
  # rounds depending on unit
  def bounds_to_strings
    rounder = Object.new.extend(SchoolShop::Rounding)

    [@lbound, @ubound].map do |bound|
      case rounding_mode
      when :to_nearest_quarter
        rounder.round_to_nearest_quarter(bound)
      when :to_nearest_half
        rounder.round_to_nearest_half(bound)
      else
        rounder.round(bound)
      end
    end
  end
end
