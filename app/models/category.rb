class Category < ActiveRecord::Base
  attr_accessible :description, :name, :parent_id

  belongs_to :category, :foreign_key => 'parent_id'
  has_many :categories, :foreign_key => 'parent_id'

  validates :name, :presence => true

  class << self
    def root
      Category.where(:name => 'root').first
    end

    def media_root
      Category.where(:name => 'media_root').first
    end
  end
end
