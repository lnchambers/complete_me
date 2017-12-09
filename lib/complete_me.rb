require_relative 'node'

 class CompleteMe
   attr_reader :root

   def initialize
     @root = Node.new
   end

   def insert(data)
     insert_data([data])
   end
   # maybe refactor to
   def insert_data(data, node = root)
     data.map do |letter|
       node.child = letter.split("")
     end
     node.branch_create(data, node)
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
