class GarmentType < ActiveRecord::Base
  attr_accessible :type

  validates_presence_of :type

  has_many :garments
end
