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
    assert_instance_of Array, complete_me.root.child
    assert_equal 0, complete_me.root.subscript
  end

  def test_that_insert_changes_child_in_node
    complete_me = CompleteMe.new
    complete_me.insert("a")

    assert_equal ["a", "b", "c"], complete_me.root.child
  end

  def test_that_child_branches_makes_new_nodes
    complete_me = CompleteMe.new
    complete_me.insert("abc")
    

    # binding.pry
    assert_equal ["a"], complete_me.root.children[0].data
    # assert_instance_of Node, complete_me.root.children[0]
    assert_instance_of Array, complete_me.root.children
  end

end
