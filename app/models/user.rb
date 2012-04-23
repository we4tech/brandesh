class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :designation, :email, :password, :password_confirmation, :remember_me
  attr_accessible :agency_id, :designation, :name

  has_one :agency
  has_many :projects, :through => :agency

  accepts_nested_attributes_for :agency

end
