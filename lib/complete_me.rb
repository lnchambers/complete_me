require_relative "node"
require 'pry'
 class CompleteMe

   attr_reader :root

   def initialize
#Setting alphabet for the rest of the trie
     @root = Node.new(Array ("a".."z"))
   end
#Insert calls on the Node method insert_traverse
   def insert(data, current_node = @root)
      @root.get_data(data)
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
