class TrendsController < ApplicationController
  before_filter :set_categories

  def index
    expenses = Expense.order('date DESC')
    @expenses_months = expenses.group_by { |e| e.date.beginning_of_month }
  end

  def category
    @category = Category.where(:slug => params[:slug]).first
    if @category.nil?
      redirect_to :status => 404
    end
    
    @monthly_data = @category.monthly_data
    @months = @monthly_data.keys
    @average = @category.average(@monthly_data)
    current_month = Date.today.strftime('%b %Y')
    if @monthly_data.has_key?(current_month)
      @current_expense = @monthly_data[current_month][:sum]
    else
      @current_expense = 0
    end
    @difference = @current_expense - @average

    respond_to do |format|
      format.html
      format.json { render :json => @monthly_data }
    end
  end

  def monthly
    @category = Category.where(:slug => params[:slug]).first
    if @category.nil?
      redirect_to :status => 404
    end
   
    @month = Date.new(params[:year].to_i, params[:month].to_i)
    @expenses = @category.expenses.where(:date => @month..@month.end_of_month).order(:date)

    @monthly_data = @category.monthly_data
    @average = @category.average(@monthly_data)

    @current_expense = @expenses.sum(:amount)
    @difference = @current_expense - @average

    render :action => 'monthly'
  end

  private
    def set_categories
      @categories = Rails.cache.read('categories')
      if @categories.nil?
        @categories = Category.all
        Rails.cache.write('categories', @categories)
      end       
    end
end
