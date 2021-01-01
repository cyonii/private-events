# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do
  user = User.new
  user.name = Faker::Name.name
  user.email = Faker::Internet.email
  user.save
end

10.times do
  event = Event.new
  event.creator = User.all.sample
  event.name = Faker::Lorem.sentence(word_count: [5, 6, 7, 8].sample) # Faker::Book.name
  event.date = rand(Date.today...Date.today + 2.years)
  event.location = Faker::Address.full_address
  event.description = Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false)
  event.save
end


50.times do
  event = Event.all.sample
  user = User.all.sample

  if !event.attendees.include?(user)
    event.attendees << user
  end
end
