require 'test_helper'

class SizeRangeTest < ActiveSupport::TestCase
  def test_from_size
    sr = SizeRange.from_size(Size.new(5, 'years'))
    assert_equal(SizeRange.new(5, 5, 'years'), sr)
  end

  def test_attr_readers
    sr = SizeRange.new(8, 9, 'years')
    assert_equal(8, sr.lbound)
    assert_equal(9, sr.ubound)
    assert_equal('years', sr.unit)
  end

  def test_conversion
    sr = SizeRange.new(8, 9, 'years').convert_to('height_cm')
    assert_equal(SizeRange.new(128, 134, 'height_cm'), sr)
  end

  def test_emptiness
    assert(SizeRange.new(nil, nil, nil).empty?)
  end

  def test_non_emptiness
    assert(!SizeRange.new(6, 7, 'years').empty?)
  end

  def test_has_range
    sr1 = SizeRange.new(110, 110, 'height_cm')
    sr2 = SizeRange.new(110, 113, 'height_cm')

    assert(!sr1.has_range?)
    assert(sr2.has_range?)
  end

  def test_to_size
    s1 = SizeRange.new(8, 8, 'years').to_size
    s2 = SizeRange.new(8, 9, 'years').to_size

    assert_equal(Size.new(8, 'years'), s1)
    assert_nil(s2)
  end

  def test_to_s_for_no_range
    sr = SizeRange.new(8, 8, 'years')
    assert_equal('8 years', sr.to_s)
  end

  def test_to_s_for_inches
    sr = SizeRange.new(12, 13, 'collar_inches')
    assert_equal('12-13"', sr.to_s)
  end

  def test_to_s_for_cm
    sr = SizeRange.new(98, 104, 'height_cm')
    assert_equal('98-104cm', sr.to_s)
  end

  def test_to_s_for_years
    sr = SizeRange.new(5, 6, 'years')
    assert_equal('5-6 years', sr.to_s)
  end
end
