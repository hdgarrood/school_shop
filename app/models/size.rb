require 'school_shop/rounding'

class Size < ValueObject::Base
  include ActiveModel::Validations

  has_fields :lbound, :ubound, :unit

  validates :unit, :inclusion => { :in => %w(inches cm years) },
                   :presence => true
  validates :lbound, :presence => true,
                     :numericality => { :less_than_or_equal_to => :ubound }
  validates :ubound, :presence => true

  def has_range?
    @lbound < @ubound
  end
end
