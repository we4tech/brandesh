class User < ActiveRecord::Base

  TYPES = [:advertiser, :brand_executive, :student, :delegate, :other]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable
  # and :omniauthable, :confirmable,
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  validates :name, :designation, :email, :user_type, :any_phone, :presence => true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :designation, :email, :password, :password_confirmation, :remember_me
  attr_accessible :agency_ids, :designation, :name, :user_type, :personal_email,
                  :agencies_attributes, :official_phone, :personal_phone,
                  :projects_attributes, :admin, :corporate_email, :picture

  has_and_belongs_to_many :agencies
  has_many :projects, :through => :agencies
  has_many :owned_projects, :foreign_key => 'user_id', :class_name => 'Project'

  accepts_nested_attributes_for :agencies, :reject_if => :all_blank

  has_attached_file :picture,
                    :styles => { :thumb  => "260x180#" }
  validates_attachment :picture, :presence => true, :size => { :in => 0..5.megabytes }

  TYPES.each do |_type|
    self.send :define_method, :"#{_type}?", proc {
      _type.to_s == self.user_type
    }

    self.send :scope, :"#{_type}", where(user_type: _type)
  end

  scope :recent, order('created_at DESC')

  def any_phone
    personal_phone || official_phone
  end

  def found_new_agency_with_value?
    record = self.agencies.select { |a| a if a.new_record? }.first
    if record
      record.attributes.values.compact.length > 0
    else
      false
    end
  end

  def admin?
    self.admin && 'admin' == self.user_type
  end

end
