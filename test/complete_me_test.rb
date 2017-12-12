require "minitest/autorun"
require "minitest/pride"
require "pry"
require_relative "../lib/complete_me"

class CompleteMeTest < Minitest::Test

  def test_it_exists
    complete_me = CompleteMe.new

    assert_instance_of CompleteMe, complete_me
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
