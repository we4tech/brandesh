# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :agency do
    name
    phone "+323232323"
    email
    website "http://sss.com"
    street "mohammadpur, dhaka"
    area "mohammad pur"
    city "dhaka"
  end
end
