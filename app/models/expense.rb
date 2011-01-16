class Expense < ActiveRecord::Base
  @@descriptions = %w(Cash Credit\ Card)
  @@payment_choices = %w(CA CC)

  belongs_to :category
  validates_presence_of :description, :payment, :amount, :date
  validates_inclusion_of :payment, :in => @@payment_choices

  def self.payment_choices
    # class method
    @@descriptions.zip(@@payment_choices)
  end

  def payment_display
    # instance method
    index = @@payment_choices.index(self.payment)
    @@descriptions[index]
  end

  def amount_display
    '%.2f' % self.amount
  end
end
