require 'test_helper'
require 'size'

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

  def test_comparison

  end
end
