require_relative "test_helper"
require "./lib/node"

class NodeTest < Minitest::Test

  def test_it_exists
    node = Node.new("node")

    assert_instance_of Node, node
  end

  def test_it_accepts_data
    node = Node.new("data")

    assert_equal "data", node.data
  end

  def test_that_child_node_is_empty_array
    node = Node.new("string")

    assert_instance_of Array, node.child
    assert_equal [], node.child
  end

  def test_that_child_node_creates_new_nodes
    node = Node.new("abc")
    node.child << "a" << "b" << "c"
    node.branch_create

    assert_equal "a", node.next_node.data
    assert_equal "b", node.next_node.next_node.data
    assert_equal "c", node.next_node.next_node.next_node.data
  end



end
