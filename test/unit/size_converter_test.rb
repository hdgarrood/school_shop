require 'test_helper'
require 'size_converter'

class SizeConverterTest < ActiveSupport::TestCase
  def setup
    @sc = SizeConverter.new
  end

  def test_converting_years_to_height_cm
    result = @sc.years_to_height_cm(6)
    assert_equal(result, 116)
  end
end
