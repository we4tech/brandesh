class Project < ActiveRecord::Base
  attr_accessible :ad_title, :ad_headline, :ad_description, :media,
                  :ad_short_rationale, :ad_consumer_insight, :brand, :proof,
                  :brand_manager, :brand_details, :published_on, :media_type_id,
                  :category_id, :ad_rationale, :credits_hash, :additional_credits

  validates_presence_of :ad_title, :ad_headline, :brand, :brand_details, :media_type_id

  belongs_to :agency
  belongs_to :category
  belongs_to :media_type, :foreign_key => 'media_type_id', :class_name => 'Category'

  has_attached_file :media
  has_attached_file :proof

  validates_attachment :media, :presence => true, :size => { :in => 0..50.megabytes }
  validates_attachment_presence :proof
  serialize :credits_hash

  CREDIT_FIELDS = {
      'TV'        => [
          'Advertising Agency', 'Creative Director',
          'Copy writer', 'Cameraman', 'Editor',
          'Music Director', 'Additional Credits'
      ],

      'Print'     => [
          'Advertising Agency',
          'Creative Director',
          'Copywriter',
          'Art Director',
          'Photographer',
          'Illustrator',
          'Graphic Designer',
          'Additional Credits'
      ],

      'Radio'     => [
          'Advertising Agency',
          'Creative Director',
          'Copy writer',
          'Sound Editor',
          'Editor',
          'Music Director',
          'Additional Credits'
      ],

      'Outdoor'   => [
          'Creative Director',
          'Copywriter',
          'Art Director',
          'Photographer',
          'Illustrator',
          'Graphic Designer',
          'Additional Credits'
      ],

      'New Media' => [
          'Creative Director',
          'Copy writer',
          'Project Director',
          'Editor',
          'Music Director',
          'Additional Credits'
      ]
  }

end
