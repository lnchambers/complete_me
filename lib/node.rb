class Node

  attr_reader :data, :child

#Attributes of all nodes
  def initialize(data, child = nil)
    @data = data
    @child = child
  end

#creating a smart node traversal method. Will need insert method
  def insert_traverse(data)
    child = Node.new(data, child)
  end


end
