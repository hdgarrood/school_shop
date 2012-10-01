require 'school_shop/rounding'

class Size < ValueObject
  include ActiveModel::Validations

  has_fields :lbound, :ubound, :unit

  validates :unit, :inclusion => { :in => %w(inches cm years) },
                   :presence => true
  validates :lbound, :presence => true,
                     :numericality => { :less_than_or_equal_to => :ubound }
  validates :ubound, :presence => true

  def to_s
    # if all attributes are nil, return ""
    return "" if empty?

    unit_str = @unit == 'inches' ? 'inches' : @unit
    lbound_str, ubound_str = bounds_to_strings

    lbound_str == ubound_str ?
      "#{lbound_str} #{unit_str}" :
      "#{lbound_str}-#{ubound_str} #{unit_str}"
  end

  private
  # how should we round values for display?
  ROUND_MODES = {
    :to_nearest_quarter => %w(waist_inches height_inches collar_inches chest_inches),
    :to_nearest_half => %w(waist_cm),
  }

  # converts lbound and ubound to strings for display
  # rounds depending on unit
  def bounds_to_strings
    rounder = Object.new.extend(SchoolShop::Rounding)

    [@lbound, @ubound].map do |bound|
      if ROUND_MODES[:to_nearest_quarter].include?(@unit)
        rounder.round_to_nearest_quarter(bound)
      elsif ROUND_MODES[:to_nearest_half].include?(@unit)
        rounder.round_to_nearest_half(bound)
      else
        rounder.round(bound)
      end
    end
  end
end
