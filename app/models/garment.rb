class Garment < ActiveRecord::Base
  attr_accessible :sold_at, :garment_type
  belongs_to :garment_type

  def sold?
    !sold_at.nil?
  end
end
