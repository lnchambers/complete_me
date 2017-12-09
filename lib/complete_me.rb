require_relative "node"
require 'pry'
 class CompleteMe

   attr_reader :root

   def initialize
#Setting alphabet for the rest of the trie
     @root = Node.new
   end
#Insert calls on the Node method insert_traverse
   def insert(data, current_node = @root)
     data.downcase.split("").each do |letter|
       if letter == current_node.children.assoc(letter)
         current_node = Node.new(letter)
         put_new_node(current_node)
       else
         put_new_node(current_node)
         return
       end
     end
   end

   def put_new_node(current_node)
     current_node.children << current_node
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
