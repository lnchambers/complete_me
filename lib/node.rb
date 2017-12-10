class Node
  attr_reader :letter,
              :children,
              :final_letter

  def initialize(letter = nil)
    @letter       = letter
    @children     = Hash.new
    @final_letter = false
  end

  def end_of_word
    @final_letter = !@final_letter
  end

  def add_child(node)
    @children[node.letter] = node
  end
end
