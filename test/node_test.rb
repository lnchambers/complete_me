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



end
