FactoryGirl.define do

  factory :application, class: BsmOa::Application do
    sequence(:name) { |n| "Application #{n}" }
    redirect_uri 'https://app.com/callback'
    permissions ['admin', 'finance', 'operations']
  end

  factory :authorization, class: BsmOa::Authorization do
    role
    application
    permissions ['admin']
  end

  factory :role, class: BsmOa::Role do
    name { Faker::Lorem.word }
  end

  factory :user do
    email   { Faker::Internet.email }
  end

end
