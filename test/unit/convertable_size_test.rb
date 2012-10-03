require 'test_helper'

class ConvertableSizeTest < ActiveSupport::TestCase
  test "to_s_for_no_range" do
    cs = ConvertableSize.new(8, 8, 'years', 'height')
    assert_equal('8 years', cs.to_s)
  end

  test "to_s_for_inches" do
    cs = ConvertableSize.new(12, 13, 'inches', 'height')
    assert_equal('12-13"', cs.to_s)
  end

  test "to_s_for_cm" do
    cs = ConvertableSize.new(98, 104, 'cm', 'height')
    assert_equal('98-104cm', cs.to_s)
  end

  test "to_s_for_years" do
    cs = ConvertableSize.new(5, 6, 'years', 'height')
    assert_equal('5-6 years', cs.to_s)
  end

  test "converting to other units" do
    cs1 = ConvertableSize.new(98, 104, 'cm', 'height')
    cs2 = ConvertableSize.new(3, 4, 'years', 'height')
    cs3 = ConvertableSize.new(38.5, 41, 'inches', 'height')

    assert_equal(cs1, cs2.convert_to('cm'))
    assert_equal(cs2, cs3.convert_to('years'))
    assert_equal(cs3, cs1.convert_to('inches'))
  end
end
