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
             garment_type.measured_by).convert_to(size_unit)
  end

  def size=(new_size)
    # ensure that this works when +new_size+ is either a Size or a hash
    normalized_size = Size.new(new_size.to_hash).convert_to('normalized')

    # the following should ensure that the size saved to the DB is
    # always normalized.
    if normalized_size
      self.size_lower_bound = normalized_size.lower_bound
      self.size_upper_bound = normalized_size.upper_bound
      self.size_unit = normalized_size.unit
    end
  end
end
