class GarmentDescription < ActiveRecord::Base
  attr_accessible :description

  validates_presence_of :description

  has_many :garments
end
