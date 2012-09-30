require 'rounding'

class Size
  extend SizeConverter
  attr_reader :lbound, :ubound, :unit

  def initialize(*args)
    if args.length == 1 && args[0].is_a?(Hash)
      arglist = args[0][:lbound], args[0][:ubound], args[0][:unit]
    else
      arglist = args
    end
    @lbound, @ubound, @unit = arglist
  end

  def convert_to(other_unit)
    other_lbound = Size.convert(@lbound, @unit, other_unit)
    other_ubound = Size.convert(@ubound, @unit, other_unit)
    Size.new(other_lbound, other_ubound, other_unit)
  end

  def ==(other)
    if @unit == other.unit
      @lbound == other.lbound && @ubound == other.ubound
    elsif (converted = other.convert_to(@unit))
      @lbound == converted.lbound && @ubound == converted.ubound
    else
      nil
    end
  end

  def empty?
    @lbound.nil? && @ubound.nil? && @unit.nil?
  end

  def has_range?
    @lbound != @ubound
  end

  def to_s
    # if all attributes are nil, return ""
    return "" if empty?

    unit_str = @unit.sub('inches', '"')
    lbound_str, ubound_str = bounds_to_strings

    if unit_str.include?('_')
      lbound_str == ubound_str ?
        "#{lbound_str}#{unit_str.split('_')[1]}" :
        "#{lbound_str}-#{ubound_str}#{unit_str.split('_')[1]}"
    else
      lbound_str == ubound_str ?
        "#{lbound_str} #{unit_str}" :
        "#{lbound_str}-#{ubound_str} #{unit_str}"
    end
  end

  private
  # how to round values for display?
  ROUND_MODES = {
    :to_nearest_quarter => %w(waist_inches height_inches collar_inches chest_inches),
    :to_nearest_half => %w(waist_cm),
  }

  # converts lbound and ubound to strings for display
  # rounds depending on unit
  def bounds_to_strings
    rounder = Object.new.extend(Rounding)

    [@lbound, @ubound].map do |bound|
      if ROUND_MODES[:to_nearest_quarter].include?(@unit)
        rounder.round_to_nearest_quarter(bound)
      elsif ROUND_MODES[:to_nearest_half].include?(@unit)
        rounder.round_to_nearest_half(bound)
      else
        rounder.round(bound)
      end
    end
  end
end
