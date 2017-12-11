class Node
  attr_reader   :letter,
                :children,
                :final_letter
  attr_accessor :weight

  def initialize(letter = nil)
    @letter       = letter
    @children     = Hash.new
    @final_letter = false
    @weight       = 0
  end

  def end_of_word
    @final_letter = !@final_letter
  end

  def add_child(node)
    @children[node.letter] = node
  end

  def is_a_word?
    @final_letter
  end
end
