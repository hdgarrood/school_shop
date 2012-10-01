# Like a size, but also has a measurement (height, weight, chest, collar)
# which means it can be converted between years and cm/inches.
class ConvertableSize < Size
  extend SizeConverter
  has_fields :measurement
  validates :measurement, :inclusion => { :in => %w(height weight chest collar) }

  def convert_to(new_measurement)
    new_lbound = convert_bound(@lbound)
    new_ubound = convert_bound(@ubound)
    ConvertableSize.new(new_lbound, new_ubound, @unit, new_measurement)
  end

  def to_size
    Size.new(@lbound, @ubound, @unit)
  end

  private
  def convert_bound(bound, new_measurement)
    ConvertableSize.convert(bound, @unit, @measurement, new_measurement)
  end
end
