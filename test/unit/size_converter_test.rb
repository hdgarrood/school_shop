require 'test_helper'
require 'size'

class SizeConverterTest < ActiveSupport::TestCase
  def test_converting_years_to_height_cm
    result = Size.years_to_height_cm(6)
    assert_equal(116, result)
  end

  def test_converting_from_inches_to_years
    result = Size.height_inches_to_years(38.5)
    assert_equal(3, result)
  end

  def test_returns_nil_when_out_of_bounds
    result = Size.years_to_height_cm(5000)
    assert_nil(result)
  end

  def test_interpolates
    result = Size.chest_cm_to_years(84)
    assert_equal(13.5, result)
  end
end
