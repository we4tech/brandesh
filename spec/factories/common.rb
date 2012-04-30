# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :name do |n|
    "Agency #{n}"
  end

  sequence :email do |n|
    "email.user#{n}@email.com"
  end
end
