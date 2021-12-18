# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

100.times do
  user = User.new(username: Faker::Internet.username, password: 'Password@18')
  user.save!

  (0..5).to_a.sample.times do
    goal = user.goals.new(
      description: Faker::Lorem.sentence(word_count: 2),
      amount: Faker::Number.decimal(l_digits: 2),
      target_date: Faker::Date.between(from: Date.today, to: Date.today + 10.years)
    )
    goal.save!
  end
end
