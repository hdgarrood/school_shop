class Garment < ActiveRecord::Base
  attr_accessible :sold_at

  belongs_to :garment_type

  def sold?
    !sold_at.nil?
  end
end
