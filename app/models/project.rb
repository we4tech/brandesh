class Project < ActiveRecord::Base
  attr_accessible :ad_title, :ad_headline,:ad_description,
                  :ad_short_rationale,:ad_consumer_insight, :brand,
                  :brand_manager,:brand_details, :account_manager, :creative_directory,
                  :art_director, :copywriter, :illustrator, :photographer, :digital_producer,
                  :creative_developer, :creative_strategy, :sound_director,:additional_credits,
                  :media_type, :published_on, :category, :media_filename, :proof_filename

  validates_presence_of :ad_title, :ad_headline, :brand, :brand_details, :media_type
  
  belongs_to :agency
end
