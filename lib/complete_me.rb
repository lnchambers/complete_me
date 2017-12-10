require_relative 'node'

class CompleteMe
  attr_reader :root,
              :word_count

 def initialize
   @root       = Node.new
   @word_count = 0
 end

 def insert(word, current_node = @root)
   #take word, downcase and create new child node for each letter
   prepped_word = word.downcase.chars.map do |letter|
     Node.new(letter)
   end
   #next, send array of new nodes and set word into dictionary
   place_word(prepped_word)
   @word_count += 1
 end

 def create_word(node_list, parent = @root)
   #set final node to var
   final_node = node_list.last
   #create hash of nodes to set final letter as true to complete word
   existing_node = parent.children[node.letter]
   node.end_of_word if existing_node.nil?
   existing_node.end_of_word if !existing_node.nil?
 end

 def place_word(node_list, parent = @root)
   #take output of create node
   create_word(node_list, parent) if node_list.length == 1
   #remove each first node one at a time
   node = node_list.shift
   #use recursion to place each letter (node) into the trie
   place_word(node_list, parent.children[node.letter]) if key_exists(node, parent)
   add_child(node, node_list, parent) if!key_exists(node, parent)
 end

  def key_exists?(node, parent)
    parent.children.has_key?(node.letter)
  end

  def add_child(node, node_list, parent)
    parent.add_child(node)
    place_word(node_list, node)
  end

  def count
    @word_count
  end

  def suggest()
  end

  def dictionary
  end

  def populate()
  end
end
