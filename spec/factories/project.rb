require 'faker'

FactoryGirl.define do
  factory :project do
    association :user

    title       { Faker::Hacker.abbreviation }
    description { Faker::Hacker.say_something_smart }

    after(:build) do |project|
      3.times do |i|
        project.tasks << FactoryGirl.build(:task, project: project)
      end
    end
  end
end