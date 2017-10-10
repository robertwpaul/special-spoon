FactoryGirl.define do
  factory :event do
    title { Faker::Lorem.word }
    zip { Faker::Number.number(5) }
  end
end