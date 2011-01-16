class AddCategoryToKeywords < ActiveRecord::Migration
  def self.up
    add_column :keywords, :category_id, :integer
  end

  def self.down
    remove_column :keywords, :category_id
  end
end
