require_relative 'test_helper'
require './lib/trie'

class TrieTest < Minitest::Test

  def test_it_exists

    trie = Trie.new

    assert_instance_of Trie, trie
  end

  def test_trie_has_desired_attributes

    trie = Trie.new

    assert_instance_of Node, trie.root
    assert_equal 0, trie.word_count
  end

  def test_word_downcase_downcases_given_word

    trie = Trie.new

    assert_equal "word", trie.downcase_word("WoRd")
  end

  def test_create_array_of_nodes_creates_an_array_of_node_instances

    trie = Trie.new

    downcased_word = trie.downcase_word("word")

    assert_instance_of Array, trie.create_array_of_nodes(downcased_word)
    assert_equal "w", trie.create_array_of_nodes(downcased_word).first.letter
    assert_equal "d", trie.create_array_of_nodes(downcased_word).last.letter
  end

  def test_full_format_creates_array_of_node_instances

    trie = Trie.new

    assert_instance_of Array, trie.full_format("word")
    assert_instance_of Node, trie.full_format("word").first
    assert_instance_of Node, trie.full_format("word")[1]
    assert_instance_of Node, trie.full_format("word")[2]
    assert_instance_of Node, trie.full_format("word")[3]
    assert_equal "w", trie.full_format("word").first.letter
    assert_equal "o", trie.full_format("word")[1].letter
    assert_equal "r", trie.full_format("word")[2].letter
    assert_equal "d", trie.full_format("word")[3].letter
  end

  def test_that_insert_creates_new_node

    trie = Trie.new
    trie.insert("abc")

    assert_equal "a", trie.root.children.first.first
    assert_equal "b", trie.root.children.first[1].children.first[0]
    assert_equal "c", trie.root.children.first[1].children.first[1].children.first[0]
    assert_instance_of Array, trie.root.children.values
  end

  def test_that_word_count_increases_after_insert

    trie = Trie.new
    trie.insert("abc")

    assert_equal 1, trie.word_count

    trie.insert("cba")

    assert_equal 2, trie.word_count

    trie.insert("three")
    trie.insert("four")
    trie.insert("five")

    assert_equal 5, trie.word_count
  end

  def test_populate_add_words_from_txt_file
    trie = Trie.new
    trie.populate_from_txt_file("/usr/share/dict/words")

    assert_equal 235886, trie.count

    trie.insert("whatever")

    assert_equal 235887, trie.word_count
  end

  def test_suggest_can_suggest_a_word
    trie = Trie.new

    trie.insert("pizza")

    assert_equal "p", trie.root.children.first.first
    assert_equal 1, trie.count
    assert_instance_of Array, trie.suggest("piz")
    assert_equal ["pizza"], trie.suggest("piz")
  end

  def test_load_from_dictionary_and_suggest_array_of_mulitiple_words_and_is_case_insensitive
    trie = Trie.new

    trie.populate_from_txt_file("/usr/share/dict/words")
    assert_equal 235886, trie.count

    assert_instance_of Array, trie.suggest("piz")
    assert_equal ["pize", "pizza", "pizzeria", "pizzicato", "pizzle"], trie.suggest("piz")
    assert_equal ["pize", "pizza", "pizzeria", "pizzicato", "pizzle"], trie.suggest("PIZ")

    assert_equal [], trie.suggest("ppp")
  end

  def test_populate_inserts_words_from_string

    trie = Trie.new

    trie.populate("pize\npizza\npizzeria")
    assert_equal 3, trie.count

    trie.populate("luke\nzac\ncameron")
    assert_equal 6, trie.count
  end

  def test_populate_from_csv_inserts_full_address_from_file_path
    trie = Trie.new
    trie.populate_from_csv_file("./data/addresses.csv")

    assert_equal 307001, trie.count
    assert_equal "1", trie.root.children.first.first
    assert_equal "7", trie.root.children.first[1].children.first[0]
    assert_equal "6", trie.root.children.first[1].children.first[1].children.first[0]
  end

  def test_downcase_word_downcases_word
    trie = Trie.new

    assert_equal "this is a downcased string", trie.downcase_word("tHIs iS a DOWncAseD stRINg")
    assert_equal "another string", trie.downcase_word("ANOtheR stRINg")
  end

  def test_word_exists_verifies_against_dictionary_and_is_case_insensitive
    trie = Trie.new
    trie.populate_from_txt_file("/usr/share/dict/words")

    assert trie.word_exists?("PiZZa")
    refute trie.word_exists?("ppp")
  end

  def test_words_deleted_with_manual_insertion
    trie = Trie.new
    trie.insert("pizza")
    trie.insert("pizzaria")
    trie.insert("pizzacato")

    assert_equal 3, trie.count

    trie.delete("pizza")

    assert_equal 2, trie.count
  end

  def test_that_words_can_be_deleted_from_dictionary
    trie = Trie.new
    trie.populate_from_txt_file("/usr/share/dict/words")


    assert_equal 235886, trie.count

    trie.delete("pizza")

    assert_equal 235885, trie.count
    refute trie.word_exists?("pizza")
  end

  def test_that_different_words_can_be_deleted
    trie = Trie.new
    trie.insert("you")
    trie.insert("yours")
    trie.insert("yourself")
    trie.insert("yourselves")

    assert_equal 4, trie.count

    trie.delete("yourself")

    assert_equal 3, trie.count
  end
end
