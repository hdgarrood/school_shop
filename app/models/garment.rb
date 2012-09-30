class Garment < ActiveRecord::Base
  attr_accessible :sold_at,
                  :garment_type_id,
                  :_size

  belongs_to :garment_type

  composed_of :_size,
              :class_name => 'Size',
              :mapping => [%w(size_lbound lbound),
                           %w(size_ubound ubound),
                           %w(size_unit unit)],
              :converter => Proc.new { |params| Size.new(params) }

  validates_presence_of :garment_type
  validates_presence_of :_size
  # note that a Garment will only be stored with a size_unit as one of
  # these values; however, the associated garment_type will be used so
  # that it appears that its size is height_cm or waist_cm or whatever.
  validates :size_unit, :inclusion => { :in => %w(cm inches years) }

  def sold?
    !sold_at.nil?
  end

  # 'public' size reader so that it is given with the correct unit, depending
  # on how that garment type is measured.
  #
  # Purpose: so that a pair of trousers with 'inches' in the DB comes out with
  # the unit 'waist_inches'
  def size
    convertable_unit = _size.unit == 'years' ?
      'years' : "#{garment_type.measured_by}_#{_size.unit}"
    Size.new(_size.lbound, _size.ubound, convertable_unit)
  end

  # 'public' size writer -- removes measured_by info from the unit if present
  # so that it does the inverse of the reader.
  def size=(new_size)
    new_unit = new_size.unit.gsub(/(waist|height|chest|collar)/, '')
    _size = Size.new(new_size.lbound, new_size.ubound, new_unit)
  end
end
