require_relative "test_helper"
require_relative "../lib/complete_me"
require_relative "../lib/node"

class CompleteMeTest < Minitest::Test

  def test_it_exists
    complete_me = CompleteMe.new

    assert_instance_of CompleteMe, complete_me
  end

  def test_root_has_desired_attributes
    complete_me = CompleteMe.new

    assert_instance_of Node, complete_me.root
    assert_instance_of Array, complete_me.root.data
    assert_equal ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
                  "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x",
                  "y", "z"], complete_me.root.data
  end

  def test_that_insert_creates_new_node
    complete_me = CompleteMe.new
    complete_me.insert("abc")


    binding.pry
    assert_equal ["a", "b", "c"], complete_me.root.children.data
    # assert_instance_of Node, complete_me.root.children[0]
    assert_instance_of Array, complete_me.root.children
  end

end
