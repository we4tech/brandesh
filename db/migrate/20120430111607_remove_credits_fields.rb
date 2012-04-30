class RemoveCreditsFields < ActiveRecord::Migration
  def up
    [:account_manager, :creative_directory, :art_director, :copywriter,
     :illustrator, :photographer, :digital_producer, :creative_developer,
     :creative_strategy, :sound_director].each do |f|
      remove_column :projects, f
    end
  end

  def down
    [:account_manager, :creative_directory, :art_director, :copywriter,
     :illustrator, :photographer, :digital_producer, :creative_developer,
     :creative_strategy, :sound_director].each do |f|
      add_column :projects, f, :string
    end
  end
end
