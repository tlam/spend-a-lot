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
      return true if keyword.words.upcase == keywords.upcase
    end
    return false
  end

  def chart
    month_expenses = Expense.where('category_id = ?', self.id).order('date').group_by { |c| c.date.beginning_of_month }

    bar_data = []
    month_data = []
    month_expenses.each do |month, expenses|
      sum = 0
      expenses.each do |expense|
        sum += expense.amount
      end
      bar_data.push(sum)
      month_data.push(month.strftime('%b %Y'))
    end

    max_value = bar_data.max
    y_axis =  '0|%.2f|%.2f|%.2f|%.2f' % [max_value*0.25, max_value*0.5, max_value*0.75, max_value]
    month_data = [month_data.join('|'), y_axis]

    @bar = Gchart.bar(:data => bar_data,
                      :axis_with_labels => 'x,y',
                      :axis_labels => month_data,
                      :bar_width_and_spacing => '30,22',
                      :size => '960x200')
  end
end
