class Garment < ActiveRecord::Base
  attr_accessible :garment_type_id,
                  :price

  belongs_to :garment_type
  validates_presence_of :garment_type
  validates :price, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ },
                    :numericality => { :greater_than => 0 }

  def sold?
    !sold_at.nil?
  end

  def to_s
    "#{self.class.model_name.human} ##{id}"
  end
end
