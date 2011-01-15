class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.string :description
      t.string :type
      t.decimal :amount
      t.datetime :date

      t.timestamps
    end
  end

  def self.down
    drop_table :expenses
  end
end
