class Agency < ActiveRecord::Base
  attr_accessible :street, :area, :city, :email, :name, :phone, :website

  validates :name, :presence => true, :uniqueness => true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  has_many :users
  has_many :projects


end
