class AddPhonesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :personal_phone, :string
    add_column :users, :official_phone, :string
  end
end
