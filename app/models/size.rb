class Size < ValueObject::Base
  has_fields :lbound, :ubound, :unit

  def self.unit_values
    %w(years inches cm)
  end

  def has_range?
    @lbound < @ubound
  end
end
