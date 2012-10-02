class Size < ValueObject::Base
  has_fields :lbound, :ubound, :unit

  def has_range?
    @lbound < @ubound
  end
end
