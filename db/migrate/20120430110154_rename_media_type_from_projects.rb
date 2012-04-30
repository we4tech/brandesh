class RenameMediaTypeFromProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :media_type
    add_column :projects, :media_type_id, :integer
  end

  def down
    add_column :projects, :media_type, :string
    remove_column :projects, :media_type_id
  end
end
