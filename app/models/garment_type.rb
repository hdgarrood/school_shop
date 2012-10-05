class GarmentType < ActiveRecord::Base
  attr_accessible :name, :measured_by
  validates_presence_of :name
  has_many :garments

  def to_s
    name
  end
end
