class Garment < ActiveRecord::Base
  attr_accessible :sold_at, :garment_type
  belongs_to :garment_type

  composed_of :size_range,
              :mapping => [%w(size_lbound lbound),
                           %w(size_ubound ubound),
                           %w(size_unit unit)]

  def sold?
    !sold_at.nil?
  end
end
