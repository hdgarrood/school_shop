class Garment < ActiveRecord::Base
  attr_accessible :sold_at,
                  :garment_type_id,
                  :size_lower_bound,
                  :size_upper_bound,
                  :size_unit

  belongs_to :garment_type

  validates_presence_of :garment_type
  validates :size_lower_bound, :numericality => { :less_than_or_equal_to => :size_upper_bound }
  validates :size_upper_bound, :numericality => :true
  validates :size_unit, :inclusion => { :in => Size.unit_values }

  def sold?
    !sold_at.nil?
  end
end
