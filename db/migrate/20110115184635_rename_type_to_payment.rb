class RenameTypeToPayment < ActiveRecord::Migration
  def self.up
    rename_column :expenses, :type, :payment
  end

  def self.down
    rename_column :expenses, :payment, :type
  end
end
