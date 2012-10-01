require 'test_helper'

class ConvertableSizeTest < ActiveSupport::TestCase
  test "to_s_for_no_range" do
    sr = ConvertableSize.new(8, 8, 'years', 'height')
    assert_equal('8 years', sr.to_s)
  end

  test "to_s_for_inches" do
    sr = ConvertableSize.new(12, 13, 'inches', 'height')
    assert_equal('12-13"', sr.to_s)
  end

  test "to_s_for_cm" do
    sr = ConvertableSize.new(98, 104, 'cm', 'height')
    assert_equal('98-104cm', sr.to_s)
  end

  test "to_s_for_years" do
    sr = ConvertableSize.new(5, 6, 'years', 'height')
    assert_equal('5-6 years', sr.to_s)
  end
end
