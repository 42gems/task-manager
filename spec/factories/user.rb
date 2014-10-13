require 'faker'

FactoryGirl.define do
  factory :user do
    association :project

    email    { Faker::Internet.safe_email }
    password { Faker::Internet.password(8) }

    after(:build) { |user| user.projects << FactoryGirl.build(:project, user: user) }
  end
end