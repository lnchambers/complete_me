require 'pry'
require_relative "node"

class CompleteMe
  attr_reader :root,
              :word_count

  def initialize
    @root       = Node.new
    @word_count = 0
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

  def populate(input)
    input = "../complete_me_spec_harness/test/" + input.to_s
    File.open(input).readlines.each { |word| insert(word.chomp) }
  end

  def count
    @word_count
  end

  def suggest()
  end

  def dictionary
  end
end
