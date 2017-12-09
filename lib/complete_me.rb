require_relative "node"
require 'pry'
 class CompleteMe

   attr_reader :root

   def initialize
#Setting alphabet for the rest of the 
     @root = Node.new(Array ("a".."z"))
   end
#Insert calls on the Node method insert_traverse
   def insert(data)
      node = Node.new(data)
      binding.pry
      node.insert_traverse(data)
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
