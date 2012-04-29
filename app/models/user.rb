class User < ActiveRecord::Base

  TYPES = [:advertiser, :brand_executive, :student, :delegate]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable
  # and :omniauthable, :confirmable,
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  validates :name, :designation, :email, :user_type, :any_phone, :presence => true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :designation, :email, :password, :password_confirmation, :remember_me
  attr_accessible :agency_id, :designation, :name, :user_type, :personal_email,
                  :agency_attributes,
                  :projects_attributes

  has_one :agency
  has_many :projects, :through => :agency

  accepts_nested_attributes_for :agency

  TYPES.each do |_type|
    self.send :define_method, :"#{_type}?", proc {
      _type.to_s == self.user_type
    }
  end

  def any_phone
    personal_phone || official_phone
  end

end
