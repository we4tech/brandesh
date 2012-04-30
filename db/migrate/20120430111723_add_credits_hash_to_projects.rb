class AddCreditsHashToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :credits_hash, :text
  end
end
