class TrendsController < ApplicationController
  def index
    expenses = Expense.order('date DESC')
    @expenses_months = expenses.group_by { |e| e.date.beginning_of_month }
    @categories = Category.all
  end

end
