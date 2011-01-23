class TrendsController < ApplicationController
  before_filter :set_categories

  def index
    expenses = Expense.order('date DESC')
    @expenses_months = expenses.group_by { |e| e.date.beginning_of_month }
  end

  def category
    @category = Category.find(params[:id])
  end

  private
    def set_categories
      @categories = Category.all
    end
end
