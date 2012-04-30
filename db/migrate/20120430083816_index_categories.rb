class IndexCategories < ActiveRecord::Migration

  def up
    add_index :categories, [:name]
    add_index :categories, [:parent_id]
  end

  def down
    remove_index :categories, [:name]
    remove_index :categories, [:parent_id]
  end
end
