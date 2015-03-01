require 'test_helper'

class KeywordTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "create keyword" do
    keyword = Keyword.new
    keyword.words = 'blue umbrella'
    keyword.save
    assert_equal('blue umbrella', keyword.words)
  end
end
