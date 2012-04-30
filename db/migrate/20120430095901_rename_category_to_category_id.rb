class RenameCategoryToCategoryId < ActiveRecord::Migration
  def up
    remove_column :projects, :category
    add_column :projects, :category_id, :integer
  end

  def down
    add_column :projects, :category, :string
    remove_column :projects, :category_id
  end
end
