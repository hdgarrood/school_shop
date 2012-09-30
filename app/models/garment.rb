class Garment < ActiveRecord::Base
  attr_accessible :sold_at, :garment_type_id, :size_range
  belongs_to :garment_type

  composed_of :size_range,
              :mapping => [%w(size_lbound lbound),
                           %w(size_ubound ubound),
                           %w(size_unit unit)]

  def sold?
    !sold_at.nil?
  end

  # getter and setter for a size -- since a SizeRange can behave like a
  # Size if the upper bound is the same as the lower bound, we can
  # make the model behave as though it has a size attribute
  def size
    size_range.to_size
  end

  def size=(size)
    size_range = SizeRange.from_size(size)
  end
end
