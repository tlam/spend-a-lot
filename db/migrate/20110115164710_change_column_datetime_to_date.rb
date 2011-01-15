class ChangeColumnDatetimeToDate < ActiveRecord::Migration
  def self.up
    change_column :expenses, :date, :date
  end

  def self.down
    change_column :expenses, :date, :datetime
  end
end
