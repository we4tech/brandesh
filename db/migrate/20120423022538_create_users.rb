class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :agency
      t.string :name
      t.string :designation

      t.timestamps
    end
  end
end
