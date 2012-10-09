class Seller < ActiveRecord::Base
  has_many :garments

  validates :first_name,  :presence => :true
  validates :surname,     :presence => :true
  validates :sons_name,   :presence => :true
end
