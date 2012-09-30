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

  # returns a size in, say, height_cm as opposed to cm so that it can be
  # converted between years, height_inches, etc.
  def convertable_size
    convertable_unit = size.unit == 'years' ?
      'years' : "#{garment_type.measured_by}_#{size.unit}"
    Size.new(size.lbound, size.ubound, convertable_unit)
  end
end
