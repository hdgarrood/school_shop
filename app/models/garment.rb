class Garment < ActiveRecord::Base
  attr_accessible :sold_at, :garment_type
  belongs_to :garment_type

  # TODO
  # composed_of :size

  def sold?
    !sold_at.nil?
  end
end
