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

    assert_instance_of Node, complete_me.root
    assert_equal 0, complete_me.word_count
  end

  def test_word_downcase_downcases_given_word
    complete_me = CompleteMe.new

    assert_equal "word", complete_me.downcase_word("WoRd")
  end

  def test_create_array_of_nodes_creates_an_array_of_node_instances
    complete_me = CompleteMe.new

    downcased_word = complete_me.downcase_word("word")

    assert_instance_of Array, complete_me.create_array_of_nodes(downcased_word)
    assert_equal "w", complete_me.create_array_of_nodes(downcased_word).first.letter
    assert_equal "d", complete_me.create_array_of_nodes(downcased_word).last.letter
  end

  def test_full_format_creates_array_of_node_instances
    complete_me = CompleteMe.new

    assert_instance_of Array, complete_me.full_format("word")
    assert_instance_of Node, complete_me.full_format("word").first
    assert_instance_of Node, complete_me.full_format("word")[1]
    assert_instance_of Node, complete_me.full_format("word")[2]
    assert_instance_of Node, complete_me.full_format("word")[3]
    assert_equal "w", complete_me.full_format("word").first.letter
    assert_equal "o", complete_me.full_format("word")[1].letter
    assert_equal "r", complete_me.full_format("word")[2].letter
    assert_equal "d", complete_me.full_format("word")[3].letter
  end

  def test_that_insert_creates_new_node
    complete_me = CompleteMe.new
    complete_me.insert("abc")

    assert_equal "a", complete_me.root.children.first.first
    assert_equal "b", complete_me.root.children.first[1].children.first[0]
    assert_equal "c", complete_me.root.children.first[1].children.first[1].children.first[0]
    assert_instance_of Array, complete_me.root.children.values
  end

  def test_that_word_count_increases_after_insert
    complete_me = CompleteMe.new
    complete_me.insert("abc")

    assert_equal 1, complete_me.word_count

    complete_me.insert("cba")

    assert_equal 2, complete_me.word_count

    complete_me.insert("three")
    complete_me.insert("four")
    complete_me.insert("five")

    assert_equal 5, complete_me.word_count
  end

  def test_populate_add_words
    complete_me = CompleteMe.new
    complete_me.populate("/usr/share/dict/words")

    assert_equal 235886, complete_me.count

    complete_me.insert("whatever")

    assert_equal 235887, complete_me.word_count
  end

  def test_suggest_can_suggest_a_word
    complete_me = CompleteMe.new

    complete_me.insert("pizza")

    assert_equal "p", complete_me.root.children.first.first
    assert_equal 1,complete_me.count
    assert_instance_of Array, complete_me.suggest("piz")
    assert_equal ["pizza"], complete_me.suggest("piz")
  end

  def test_it_can_load_from_dictionary_and_suggest_array_of_mulitiple_words_and_is_case_insensitive
    complete_me = CompleteMe.new
    complete_me.populate("/usr/share/dict/words")

    assert_equal 235886, complete_me.count

    assert_instance_of Array, complete_me.suggest("piz")
    assert_equal ["pize", "pizza", "pizzeria", "pizzicato", "pizzle"], complete_me.suggest("piz")
    assert_equal ["pize", "pizza", "pizzeria", "pizzicato", "pizzle"], complete_me.suggest("PIZ")
  end
end
