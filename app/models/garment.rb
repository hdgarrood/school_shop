class Garment < ActiveRecord::Base
  attr_accessible :sold_at,
                  :garment_type_id,
                  :size

  belongs_to :garment_type

  validates_presence_of :garment_type
  validates :size_lower_bound, :numericality => { :less_than_or_equal_to => :size_upper_bound }
  validates :size_upper_bound, :numericality => :true
  validates :size_unit, :inclusion => { :in => Size.unit_values }

  def sold?
    !sold_at.nil?
  end

  def size
    Size.new(size_lower_bound,
             size_upper_bound,
             'normalized',
             garment_type.measured_by)
  end

  def size=(new_size)
    if (size = Size.new(new_size.to_hash))
      self.size_lower_bound = size.lower_bound
      self.size_upper_bound = size.upper_bound
      self.size_unit = size.unit
    end
  end
end
