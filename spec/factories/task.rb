require 'faker'

FactoryGirl.define do
  factory :task do
    title       { Faker::Hacker.noun }
    description { Faker::Hacker.adjective }
  end
end