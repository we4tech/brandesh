class CreateAgencies < ActiveRecord::Migration
  def change
    create_table :agencies do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :website
      t.string :street
      t.string :area
      t.string :city

      t.timestamps
    end
  end
end
