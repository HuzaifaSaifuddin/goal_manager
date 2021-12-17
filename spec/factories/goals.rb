FactoryBot.define do
  factory :goal do
    description { Faker::Lorem.sentence(word_count: 2) }
    amount { Faker::Number.decimal(l_digits: 2) }
    target_date { Faker::Date.between(from: Date.today, to: Date.today + 10.years) }
    user { create(:user) }
  end
end
