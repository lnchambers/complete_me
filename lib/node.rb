class Node

  attr_reader :data
  attr_accessor :subscript, :child, :next_node

#Attributes of all nodes
  def initialize(data = "")
    @data = data
    @child = []
    @subscript = 0
    @next_node = nil
  end

  def branch_create(child, node)
    next_node = node.data
  end

end
