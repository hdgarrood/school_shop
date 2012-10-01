require 'test_helper'

class SizeTest < ActiveSupport::TestCase
  test "has range when lbound <> ubound" do
    sr = Size.new(110, 113, 'cm')
    assert(sr.has_range?, "the size should have a range")
  end

  test "doesn't have range when lbound == ubound" do
    sr1 = Size.new(110, 110, 'cm')
    assert(!sr1.has_range?, "the size should not have a range")
  end

end
