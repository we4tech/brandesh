class RenamePersonalEmailToCorporateEmail < ActiveRecord::Migration
  def change
    rename_column :users, :personal_email, :corporate_email
  end
end
