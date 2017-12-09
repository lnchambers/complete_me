class Node
  attr_reader :letter,
              :children

  def initialize(letter = nil)
    @letter       = letter
    @children     = Hash.new
    @final_letter = false
  end

  def end_of_word
    @final_letter = true
  end

end
