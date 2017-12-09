class Node

  attr_accessor :subscript
  attr_reader :data, :children

#Attributes of all nodes
  def initialize(data = nil, child = [])
    @data = data
    @children = child
    @subscript = 0
  end
  
end
