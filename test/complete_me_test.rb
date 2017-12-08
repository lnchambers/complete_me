require "minitest/autorun"
require "minitest/pride"
require "pry"
require_relative "../lib/complete_me"

class CompleteMeTest < Minitest::Test

  def test_it_exists
    complete_me = CompleteMe.new

    assert_instance_of CompleteMe, complete_me
  end

end
