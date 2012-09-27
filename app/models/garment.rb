class Garment < ActiveRecord::Base
  attr_accessible :description, :sold

  validates_presence_of :description
  validates_presence_of :sold
end
