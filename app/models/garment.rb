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

  validates_presence_of :garment_type
  validates_presence_of :size
  validates :size_lbound, :numericality => { :less_than_or_equal_to => :size_ubound }
  validates :size_ubound, :numericality => :true
  validates :size_unit, :inclusion => { :in => Size::UNIT_VALUES }

  def sold?
    !sold_at.nil?
  end

  def convertable_size
    params = size.to_hash
    params[:measurement] = garment_type.measured_by
    ConvertableSize.new(params)
  end
end
