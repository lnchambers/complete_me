require 'test_helper'
require '../lib/trie'

class TrieTest < Minitest::Test

  def test_it_exists
    trie = Trie.new

    assert_instance_of Trie, trie
  end

  def test_starts_with_empty_attributes
    trie = Trie.new

    assert_instance_of Node, trie.root
    assert_equal 0, trie.word_count
  end

  def test_case_name

  end

end
