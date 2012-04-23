class AddFileFieldsToProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :media_filename
    remove_column :projects, :proof_filename
    change_table :projects do |t|
      t.has_attached_file :media
      t.has_attached_file :proof
    end


  end
end
