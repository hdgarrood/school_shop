class Garment < ActiveRecord::Base
  attr_accessible :sold_at,
                  :garment_type_id,
                  :size

  belongs_to :garment_type

  composed_of :size,
              :mapping => [%w(size_lbound lbound),
                           %w(size_ubound ubound),
                           %w(size_unit unit)],
              :converter => Proc.new { |params| Size.new(params) }

  def sold?
    !sold_at.nil?
  end
end
