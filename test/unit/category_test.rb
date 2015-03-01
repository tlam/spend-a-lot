require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "create category" do
    category = Category.new
    category.name = 'Books'
    category.save
    assert_equal('Books', category.name)
  end
end
