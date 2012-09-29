require 'test_helper'

class SizeConverterTest < ActiveSupport::TestCase
  def setup
    @sc = SizeConverter.new
  end

  def test_converting_years_to_height_cm
    result = s.years_to_height_cm(6)
    assert_equal(result, 6)
  end
end
