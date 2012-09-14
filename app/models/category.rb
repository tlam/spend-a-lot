class Category < ActiveRecord::Base
  default_scope :order => 'name'
  has_many :expenses
  has_many :keywords
  validates_presence_of :name
  validates :name, :presence => true, :uniqueness => true
  validates :slug, :presence => true, :uniqueness => true

  def self.assign
    Expense.find_each do |expense|
      next if expense.category
      Category.find_each do |category|
        if category.has_keywords(expense.description)
          expense.category = category
          expense.save
        end
      end
    end
  end

  def has_keywords(keywords)
    self.keywords.each do |keyword|
      return true if keyword.words.upcase == keywords.upcase
    end
    return false
  end

  def monthly_data
    month_expenses = Expense.where(:category_id => self.id).order('date').group_by { |c| c.date.beginning_of_month }

    @output = {}
    month_expenses.each do |month, expenses|
      sum = 0
      expenses.each do |expense|
        sum += expense.amount
      end
      @output[month.strftime('%b %Y')] = {:sum => sum, :date => month}
    end
    @output
  end

  def average(data=nil)
    if data
      results = data.clone
    else
      results = monthly_data()
    end
    current_month = Date.today.strftime('%b %Y')
    results.delete(current_month)
    total = 0
    results.each do |month, info|
      total += info[:sum]
    end

    if results.length > 0
      avg = total / results.length
    else
      avg = 0
    end
    return avg
  end
end
