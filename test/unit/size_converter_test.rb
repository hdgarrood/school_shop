require 'test_helper'

class SizeConverterTest < ActiveSupport::TestCase
  def test_converting_years_to_height_cm
    result = Size.convert(6, 'years', 'height_cm')
    assert_equal(116, result)
  end

  def test_converting_from_inches_to_years
    result = Size.convert(38.5, 'height_inches', 'years')
    assert_equal(3, result)
  end

  def test_returns_nil_when_out_of_bounds
    result = Size.convert(5000, 'years', 'height_cm')
    assert_nil(result)
  end

  def test_interpolates
    result = Size.convert(84, 'chest_cm', 'years')
    expected = Size.new(13.5, 'years')
    assert_equal(13.5, result)
  end
end
