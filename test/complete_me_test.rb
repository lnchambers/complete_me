require_relative "test_helper"
require_relative "../lib/complete_me"

class CompleteMeTest < Minitest::Test

  def test_it_exists
    complete_me = CompleteMe.new

    assert_instance_of CompleteMe, complete_me
  end

  def test_root_has_desired_attributes
    complete_me = CompleteMe.new

    assert_instance_of Array, complete_me.root
    assert_equal ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
                  "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x",
                  "y", "z"], complete_me.root
  end

end
