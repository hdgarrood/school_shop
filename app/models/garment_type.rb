class GarmentType < ActiveRecord::Base
  attr_accessible :name, :measured_by
  validates_presence_of :name
  validates :measured_by, :inclusion => { :in => %w(height waist chest collar) }
  has_many :garments
end
