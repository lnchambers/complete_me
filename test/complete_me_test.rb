require_relative "test_helper"
require_relative "../lib/complete_me"
require_relative "../lib/node"

class CompleteMeTest < Minitest::Test

  def test_it_exists
    complete_me = CompleteMe.new

    assert_instance_of CompleteMe, complete_me
  end

  def test_complete_me_has_desired_attributes
    complete_me = CompleteMe.new

    assert_instance_of Node, complete_me.root
    assert_instance_of Hash, complete_me.root.children
  end

  def test_that_insert_changes_child_in_node
    complete_me = CompleteMe.new
    complete_me.insert("a")

    # assert_equal "a", complete_me.root.children.key
    assert_instance_of Node, complete_me.root.children.values
  end

end
