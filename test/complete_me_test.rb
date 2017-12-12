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


end
