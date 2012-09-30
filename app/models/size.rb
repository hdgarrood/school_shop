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
    if unit_str.include?('_')
      has_range? ?
        "#{@lbound}-#{@ubound}#{unit_str.split('_')[1]}" :
        "#{@lbound}#{unit_str.split('_')[1]}"
    else
      has_range? ?
        "#{@lbound}-#{@ubound} #{unit_str}" :
        "#{@lbound} #{unit_str}"
    end
  end
end
