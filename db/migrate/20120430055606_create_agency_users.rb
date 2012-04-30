class CreateAgencyUsers < ActiveRecord::Migration
  def change
    create_table :agencies_users, :id => false do |t|
      t.integer :agency_id
      t.integer :user_id
    end
  end
end
