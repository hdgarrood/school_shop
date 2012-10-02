class Size < ValueObject::Base
  has_fields :lbound, :ubound, :unit

  UNIT_VALUES = %w(years inches cm)

  def has_range?
    @lbound < @ubound
  end
end
