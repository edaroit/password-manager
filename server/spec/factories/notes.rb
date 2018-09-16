# frozen_string_literal: true

FactoryBot.define do
  factory :note do
    title { Faker::Name.name }
    content { Faker::Lorem.sentence }
    association :user, factory: :user
  end
end
