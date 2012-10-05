class GarmentType < ActiveRecord::Base
  attr_accessible :name, :measured_by
  validates :name, :presence => true,
                   :uniqueness => true
  has_many :garments

  def to_s
    name
  end
end
