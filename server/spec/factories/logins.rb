# frozen_string_literal: true

FactoryBot.define do
  factory :login do
    username { Faker::Internet.email }
    password { Faker::Internet.password }
    site { Faker::Internet.domain_name }
    association :user, factory: :user
  end
end
