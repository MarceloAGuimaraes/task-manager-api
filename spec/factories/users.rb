FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "sorrirparanao"
    encrypted_password "sorrirparanao"
  end
end