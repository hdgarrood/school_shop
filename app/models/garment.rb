class Garment < ActiveRecord::Base
  attr_accessible :garment_type_id,
                  :price

  belongs_to :garment_type
  belongs_to :seller

  validates_presence_of :garment_type
  validates :price, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ },
                    :numericality => true

  scope :sold, where('sold_at is not null')

  def sold?
    !sold_at.nil?
  end

  def to_s
    "#{self.class.model_name.human} ##{id}"
  end

  def sell(new_price = nil)
    if sold?
      false
    else
      self.price = new_price if new_price
      self.sold_at = Time.now
      self.save
    end
  end
end
