class Agency < ActiveRecord::Base
  attr_accessible :street, :area, :city, :email, :name, :phone, :website

  has_many :users
end
