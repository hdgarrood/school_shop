require 'test_helper'

class SizeConverterTest < ActiveSupport::TestCase
  def setup
    @converter = Object.new.extend(SizeConverter)
  end

  def test_converting_years_to_height_cm
    result = @converter.convert(6, 'years', 'cm', 'height')
    assert_equal(116, result)
  end

  def test_converting_from_inches_to_years
    result = @converter.convert(38.5, 'inches', 'years', 'height')
    assert_equal(3, result)
  end

  def test_returns_nil_when_out_of_bounds
    result = @converter.convert(5000, 'years', 'cm', 'height')
    assert_nil(result)
  end

  def test_interpolates
    result = @converter.convert(84, 'cm', 'years', 'chest')
    assert_equal(13.5, result)
  end
end
