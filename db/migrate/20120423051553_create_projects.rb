class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references :agency
      #ad
      t.string :ad_title
      t.string :ad_headline
      t.text :ad_description
      t.text :ad_short_rationale
      t.text :ad_consumer_insight

      #brand
      t.string :brand
      t.string :brand_manager
      t.text :brand_details

      #credits
      t.string :account_manager
      t.string :creative_directory
      t.string :art_director
      t.string :copywriter
      t.string :illustrator
      t.string :photographer
      t.string :digital_producer
      t.string :creative_developer
      t.string :creative_strategy
      t.string :sound_director
      t.text :additional_credits

      #media
      t.string :media_type
      t.date  :published_on
      t.string :category
      t.string :media_filename
      t.string :proof_filename



      t.timestamps
    end
  end
end
