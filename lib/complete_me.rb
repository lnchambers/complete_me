require_relative 'node'

 class CompleteMe
   attr_reader :root

   def initialize
     @root       = Node.new
     @word_count = 0
   end

   def insert(word, current_node = @root)
     #take word, downcase and create new child node for each letter
     prepped_word = word.downcase.chars.map do |letter|
       Node.new(letter)
     end
     #next,send array of new nodes and set word into dictionary
     create_word(prepped_word)
   end

   def create_word(node_list, parent = @root)
     #set final node to var
     final_node = node_list.last
     #create hash
   end


   def count
   end

   def suggest()
   end

   def dictionary
   end

   def populate()
   end

 end
