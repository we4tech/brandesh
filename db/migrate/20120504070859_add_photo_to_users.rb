class AddPhotoToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.has_attached_file :picture
    end
  end
end
