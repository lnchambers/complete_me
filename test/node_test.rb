require_relative "test_helper"
require "./lib/node"

class NodeTest < Minitest::Test

  def test_it_exists
    node = Node.new

    assert_instance_of Node, node
  end

  def test_letter_is_nil_by_default
    node = Node.new

    assert_nil node.letter
  end

  def test_it_accepts_data
    node = Node.new("a")

    assert_equal "a", node.letter
  end


  def test_that_child_node_is_nil_and_add_child_adds_children
    node = Node.new
    node_1 = Node.new("a")
    assert_empty node.children

    node.add_child(node_1)

    assert_equal node_1, node.children["a"]
    assert_instance_of Node, node.children.values.first
  end

  def test_multiple_child_nodes_can_be_added
    node = Node.new
    node_1 = Node.new("a")
    node_2 = Node.new("b")
    node_3 = Node.new("c")

    assert_empty node.children

    node.add_child(node_1)
    node.add_child(node_2)
    node.add_child(node_3)

    assert_equal ["a", "b", "c"], node.children.keys
    assert_instance_of Array, node.children.values
    assert_instance_of Node, node.children.values.first
    assert_instance_of Node, node.children.values[1]
    assert_instance_of Node, node.children.values.last
  end

  def test_final_letter_defaults_to_false_and_can_be_changed_to_true_and_back_to_false
    node = Node.new
    node_1 = Node.new("a")
    node_2 = Node.new("b")
    node.add_child(node_1)
    node.add_child(node_2)

    node.children.values.last.end_of_word

    refute node.children.values.first.final_letter
    assert node.children.values.last.final_letter

    node.children.values.last.end_of_word

    refute node.children.values.first.final_letter
    refute node.children.values.last.final_letter
  end
end
