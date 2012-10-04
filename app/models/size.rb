class Size < ValueObject::Base
  extend SizeConverter
  has_fields :lower_bound, :upper_bound, :measurement

  class << self
    # valid values for @unit
    def unit_values
      %w(years inches cm normalized)
    end

    # valid values for @measurement
    def measurement_values
      %w(height chest waist collar)
    end
  end

  # override the constructor, because we want to normalize on creation
  def initialize(*args)
    if args.length == 1 && args[0].is_a?(Hash)
      arglist = %w(lower_bound upper_bound unit measurement).map do |a|
        args[0][a.to_sym]
      end
    else
      arglist = args
    end
    lower_bound, upper_bound, unit, measurement = arglist

    @lower_bound = Size.normalize(lower_bound, unit, measurement)
    @upper_bound = Size.normalize(upper_bound, unit, measurement)
    @measurement = measurement
  end

  def has_range?
    @lower_bound < @upper_bound
  end

  def show_as(unit)
    unit_str = unit == 'inches' ? '"' : unit
    lower_bound_str, upper_bound_str = bounds_to_strings

    space_or_empty = unit == 'years' ? ' ' : ''

    # note that has_range? is inappropriate here, as rounding might
    # cause #has_range? to return true if lower_bound_str ==
    # upper_bound_str
    lower_bound_str == upper_bound_str ?
      "#{lower_bound_str}#{space_or_empty}#{unit_str}" :
      "#{lower_bound_str} - #{upper_bound_str}#{space_or_empty}#{unit_str}"
  end

  private
  def rounding_mode(unit)
    if unit == 'inches'
      :to_nearest_quarter
    elsif unit == 'cm' && @measurement == 'waist'
      :to_nearest_half
    else
      :to_nearest_whole
    end
  end

  # converts lower_bound and upper_bound to strings for display
  # rounds depending on unit
  def bounds_to_strings(unit)
    rounder = Object.new.extend(Rounding)

    [lower_bound, upper_bound].map do |n_bound|
      bound = Size.normalize(n_bound, unit, @measurement)

      case rounding_mode(unit)
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
