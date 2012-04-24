class AddAdRationaleToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :ad_rationale, :text
  end
end
