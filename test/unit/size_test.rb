require 'test_helper'

class SizeTest < ActiveSupport::TestCase
  def test_can_read_attributes
    s = Size.new(3, "years")
    assert_equal(3, s.value)
    assert_equal("years", s.unit)
  end

  def test_can_convert
    s1 = Size.new(3, "years")
    s2 = s1.convert_to("height_cm")
    assert_equal(98, s2.value)
    assert_equal("height_cm", s2.unit)
  end

  def test_equality
    s1 = Size.new(3, "years")
    s2 = Size.new(3, "years")
    s3 = Size.new(98, "height_cm")
    assert(s1 == s2)
    assert(s1 != s3)
  end

  def test_comparison_with_same_units
    s1 = Size.new(12.5, 'collar_inches')
    s2 = Size.new(12.25, 'collar_inches')
    s3 = Size.new(12.75, 'collar_inches')

    assert_equal(0, s1 <=> s1)
    assert_equal(1, s1 <=> s2)
    assert_equal(-1, s1 <=> s3)
  end

  def test_comparison_with_different_units
    s1 = Size.new(24, 'chest_inches')
    s2 = Size.new(6, 'years')
    s3 = Size.new(58, 'chest_cm')
    s4 = Size.new(8, 'years')

    assert_equal(0, s1 <=> s2)
    assert_equal(1, s1 <=> s3)
    assert_equal(-1, s1 <=> s4)
  end

  def test_to_s_when_attributes_are_nil
    s1 = Size.new(nil, nil) 
    assert_equal("", s1.to_s)
  end
end
