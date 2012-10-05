class Garment < ActiveRecord::Base
  attr_accessible :sold_at,
                  :garment_type_id,
                  :price

  belongs_to :garment_type
  validates_presence_of :garment_type

  def sold?
    !sold_at.nil?
  end

  def to_s
    "#{self.class.model_name.human} ##{id}"
  end
end
