class Category < ActiveRecord::Base
  default_scope :order => 'name'
  has_many :expenses
  has_many :keywords
  validates_presence_of :name

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
      return true if keyword.words == keywords
    end
    return false
  end
end
