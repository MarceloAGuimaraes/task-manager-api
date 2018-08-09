FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "sorrirparanao"
    password_confirmation "sorrirparanao"

  end
end