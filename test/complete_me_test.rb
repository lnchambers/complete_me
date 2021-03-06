require_relative "test_helper"
require_relative "../lib/complete_me"
require_relative "../lib/node"

class CompleteMeTest < Minitest::Test

  def test_it_exists
    complete_me = CompleteMe.new

    assert_instance_of CompleteMe, complete_me
  end

  def test_complete_me_has_desired_attributes
    complete_me = CompleteMe.new

    assert_instance_of Node, complete_me.trie.root
    assert_equal 0, complete_me.trie.word_count
  end

  def test_word_downcase_downcases_given_word
    complete_me = CompleteMe.new

    assert_equal "word", complete_me.trie.downcase_word("WoRd")
  end

  def test_create_array_of_nodes_creates_an_array_of_node_instances
    complete_me = CompleteMe.new

    downcased_word = complete_me.trie.downcase_word("word")

    assert_instance_of Array, complete_me.trie.create_array_of_nodes(downcased_word)
    assert_equal "w", complete_me.trie.create_array_of_nodes(downcased_word).first.letter
    assert_equal "d", complete_me.trie.create_array_of_nodes(downcased_word).last.letter
  end

  def test_full_format_creates_array_of_node_instances
    complete_me = CompleteMe.new

    assert_instance_of Array, complete_me.trie.full_format("word")
    assert_instance_of Node, complete_me.trie.full_format("word").first
    assert_instance_of Node, complete_me.trie.full_format("word")[1]
    assert_instance_of Node, complete_me.trie.full_format("word")[2]
    assert_instance_of Node, complete_me.trie.full_format("word")[3]
    assert_equal "w", complete_me.trie.full_format("word").first.letter
    assert_equal "o", complete_me.trie.full_format("word")[1].letter
    assert_equal "r", complete_me.trie.full_format("word")[2].letter
    assert_equal "d", complete_me.trie.full_format("word")[3].letter
  end

  def test_that_insert_creates_new_node
    complete_me = CompleteMe.new
    complete_me.insert("abc")

    assert_equal "a", complete_me.trie.root.children.first.first
    assert_equal "b", complete_me.trie.root.children.first[1].children.first[0]
    assert_equal "c", complete_me.trie.root.children.first[1].children.first[1].children.first[0]
    assert_instance_of Array, complete_me.trie.root.children.values
  end

  def test_that_word_count_increases_after_insert
    complete_me = CompleteMe.new
    complete_me.insert("abc")

    assert_equal 1, complete_me.trie.word_count

    complete_me.insert("cba")

    assert_equal 2, complete_me.trie.word_count

    complete_me.insert("three")
    complete_me.insert("four")
    complete_me.insert("five")

    assert_equal 5, complete_me.trie.word_count
  end

  def test_populate_add_words_from_txt_file
    complete_me = CompleteMe.new
    complete_me.populate_from_txt_file("/usr/share/dict/words")

    assert_equal 235886, complete_me.trie.count

    complete_me.insert("whatever")

    assert_equal 235887, complete_me.trie.word_count
  end

  def test_suggest_can_suggest_a_word
    complete_me = CompleteMe.new

    complete_me.insert("pizza")

    assert_equal "p", complete_me.trie.root.children.first.first
    assert_equal 1,complete_me.trie.count
    assert_instance_of Array, complete_me.suggest("piz")
    assert_equal ["pizza"], complete_me.suggest("piz")
  end

  def test_it_can_load_from_dictionary_and_suggest_array_of_mulitiple_words_and_is_case_insensitive
    complete_me = CompleteMe.new

    complete_me.populate_from_txt_file("/usr/share/dict/words")
    assert_equal 235886, complete_me.trie.count

    assert_instance_of Array, complete_me.suggest("piz")
    assert_equal ["pize", "pizza", "pizzeria", "pizzicato", "pizzle"], complete_me.suggest("piz")
    assert_equal ["pize", "pizza", "pizzeria", "pizzicato", "pizzle"], complete_me.suggest("PIZ")

    assert_equal [], complete_me.suggest("ppp")
  end

  def test_populate_inserts_words_from_string
    complete_me = CompleteMe.new

    complete_me.populate("pize\npizza\npizzeria")
    assert_equal 3, complete_me.trie.count

    complete_me.populate("luke\nzac\ncameron")
    assert_equal 6, complete_me.trie.count
  end

  def test_populate_from_csv_inserts_full_address_from_file_path
    complete_me = CompleteMe.new

    complete_me.populate_from_csv_file("./data/addresses.csv")
    assert_equal 307001, complete_me.trie.count
    assert_equal "1", complete_me.trie.root.children.first.first
    assert_equal "7", complete_me.trie.root.children.first[1].children.first[0]
    assert_equal "6", complete_me.trie.root.children.first[1].children.first[1].children.first[0]
  end

  def test_it_has_desired_attributes
    complete_me = CompleteMe.new

    assert_instance_of Trie, complete_me.trie
    assert_instance_of Hash, complete_me.selected
  end

  def test_count_returns_number
    complete_me = CompleteMe.new

    assert_instance_of Integer, complete_me.count
  end

  def test_insert_creates_new_word
    complete_me = CompleteMe.new

    complete_me.insert("new")

    assert_equal "n", complete_me.trie.root.children.first.first
    assert_equal "e", complete_me.trie.root.children.first[1].children.first[0]
    assert_equal "w", complete_me.trie.root.children.first[1].children.first[1].children.first[0]
  end

  def test_suggest_returns_an_array_of_words
    complete_me = CompleteMe.new

    complete_me.insert("yourself")
    complete_me.insert("you")
    complete_me.insert("yours")
    complete_me.insert("your")

    assert_instance_of Array, complete_me.suggest("you")
    assert_equal "you", complete_me.suggest("you").first
  end

  def test_select_returns_selected_array_of_words
    complete_me = CompleteMe.new

    complete_me.insert("yourself")
    complete_me.insert("you")
    complete_me.insert("yours")
    complete_me.insert("your")

    assert_instance_of Array, complete_me.suggest("you")
    assert_equal "you", complete_me.suggest("you").first

    complete_me.select("you", "yours")

    assert_instance_of Array, complete_me.suggest("you")
    assert_equal "yours", complete_me.suggest("you").first

    complete_me.select("you", "your")
    complete_me.select("you", "your")

    assert_equal "your", complete_me.suggest("you").first
  end

  def test_weight_adder_for_added_weight
    complete_me = CompleteMe.new

    complete_me.insert("yourself")
    complete_me.insert("you")
    complete_me.insert("yours")
    complete_me.insert("your")

    complete_me.select("you", "yours")
    complete_me.select("you", "yours")

    assert_equal 3, complete_me.weight_adder("you", "yours")
  end

  def test_weight_sorter_to_return_highest_weighted_word_first_in_array
    complete_me = CompleteMe.new

    complete_me.insert("yourself")
    complete_me.insert("you")
    complete_me.insert("yours")
    complete_me.insert("your")

    complete_me.select("you", "yours")
    complete_me.select("you", "yours")

    assert_equal ["yours"], complete_me.weight_sorter("you")
  end
end
