require "pry"
require_relative "trie"

class CompleteMe
  attr_reader :trie,
              :selected

  def initialize
    @trie     = Trie.new
    @selected = Hash.new
  end

  def count
    @trie.word_count
  end

  def insert(word)
    @trie.insert(word)
  end

  def populate(string)
    @trie.populate(string)
  end

  def poplulate_from_txt_file(file_path)
    @trie.populate_from_txt_file(file_path)
  end

  def populate_from_csv_file(file_path)
    @trie.populate_from_csv_file(file_path)
  end

  def suggest(substring)
    if @selected[substring].nil?
      @trie.suggest(substring)
    else
      (weight_control(substring)+ @trie.suggest(substring)).uniq
    end
  end

  def select(substring, selected_word)
    return "Word not in dictionary" unless @trie.word_exists?(selected_word)
    if @selected[substring].nil?
      @selected[substring] = {selected_word => 1}
    else
      @selected[substring][selected_word] ? @selected[substring][selected_word] += 1 : @selected[substring][selected_word] = 1
    end
  end

  def weight_control(substring)
    weighted_words = @selected[substring].sort_by { |_, weight| weight }
    weighted_words.reverse!.map { |word| word[0] }
  end
end
