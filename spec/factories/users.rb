# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :corporate_email do |n|
    "personal.email#{n * Time.now.to_i}@test.com"
  end

  factory :user do
    name
    designation 'Ad maker'
    email
    user_type 'advertiser'
    corporate_email
    personal_phone '+3232323233'
    official_phone '+3232323233'

    password "abcdef"
    password_confirmation "abcdef"
  end
end
