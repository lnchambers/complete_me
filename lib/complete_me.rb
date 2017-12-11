require "csv"
require_relative "node"

class CompleteMe
  attr_reader :root,
              :word_count

  def initialize
    @root        = Node.new
    @word_count  = 0
    @node_holder = Array.new
    @word_holder = Array.new
  end

  def insert(word, current_node = @root)
    prepped_word = full_format(word)
    place_word(prepped_word)
    @word_count += 1
  end

  def downcase_word(word)
    word.downcase
  end

  def create_array_of_nodes(word)
    word.chars.map { |letter| Node.new(letter) }
  end

  def full_format(word)
    create_array_of_nodes(downcase_word(word))
  end

  def create_word(node_list, parent = @root)
    final_node = node_list.last
    existing_node = parent.children[final_node.letter]
    final_node.end_of_word    if existing_node.nil?
    existing_node.end_of_word if !existing_node.nil?
  end

  def place_word(node_list, parent = @root)
    return if node_list.empty?
    create_word(node_list, parent) if node_list.length == 1
    node = node_list.shift
    place_word(node_list, parent.children[node.letter]) if key_exists?(node, parent)
    add_child(node, node_list, parent) if !key_exists?(node, parent)
  end

  def key_exists?(node, parent)
    parent.children.has_key?(node.letter)
  end

  def add_child(node, node_list, parent)
    parent.add_child(node)
    place_word(node_list, node)
  end

  def populate(file_path)
    contents = file_path.gsub("\r\n", "\n").split("\n")
    contents.each { |word| insert(word) }
  end

  def populate_from_txt_file(file_path)
    File.open(file_path).readlines.each { |word| insert(word.chomp) }
  end

  def populate_from_csv_file(file_path)
    contents = CSV.open file_path, headers: true, header_converters: :symbol
    contents.each { |row| insert(row[:full_address]) }
  end

  def count
    @word_count
  end

  def traverse_down_trie(node_list, parent = @root)
    return nil if parent.nil?
    return @node_holder.last if node_list.empty?
    node = node_list.shift
    @node_holder << parent.children[node.letter]
    traverse_down_trie(node_list, parent.children[node.letter])
  end

  def find_all_children_words(node, word)
    @word_holder << word if node.is_a_word?
    if !node.children.empty?
      node.children.each do |letter, child_node|
        new_word = word
        new_word += letter
        find_all_children_words(child_node, new_word)
      end
    end
  end

  def suggest(word)
    prepped_word = full_format(word)
    node = traverse_down_trie(prepped_word)
    return [] if node.nil?
    find_all_children_words(node, word.downcase)
    all_words = @word_holder
    @word_holder = Array.new
    all_words
  end

  def word_exists?(word)
    prepped_word = full_format(word)
    node = traverse_down_trie(prepped_word)
    return false if node.nil?
    node_holder = @node_holder
    @node_holder = Array.new
    node_holder.last.is_a_word? ? true : false
  end

=begin
i think we need to create another file to run everything here where select would live
the reason i'm thinking this line of logic is that we don't need the trie to actually know about
any auto correct features, the trie is only the database framework that holds each word in the
dictionary. to keep from breaking SRP, we should probably rename this file to dictionary
or retrieval_trie and create a new complete_me class that runs the actual autocomplete
feature. a hecka basic start to select is below, but it should be migrated to the new
complete_me file
=end


  # def select(substring, selected_word)
  #   return "Word not in dictionary" unless word_exists?(selected_word)
  #
  #
  # end

end
