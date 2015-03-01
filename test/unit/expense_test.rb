require 'test_helper'

class ExpenseTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "create expense" do
    expense = Expense.new
    expense.description = 'Music'
    expense.save
    assert_equal('Music', expense.description)
  end
end
