# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts "Cleaning database..."

Domain.destroy_all
Bottle.destroy_all
Batch.destroy_all
Transaction.destroy_all
User.destroy_all

puts 'Creating user 1'
user1 = User.create!(
  email: 'user1@gmail.com',
  password: 'password'
)

puts "Creating 4 domains..."
(0..4).each do
  Domain.create!(
    year: Faker::Number.within(range: 1880..1980),
    name: Faker::Quotes::Chiquito.term ,
    description: Faker::Lorem.paragraph(sentence_count: 4),
    popularity: Faker::Number.within(range: 1..5),
  )
end

(0..4).each do |n|
  puts "Creating batch #{n + 1}"
  batch = Batch.create!(
    name: Faker::Artist.name,
    quantity: Faker::Number.within(range: 100..300),
    initial_price: Faker::Number.number(digits: 3),
    domain: Domain.last,
    description: Faker::Lorem.paragraph(sentence_count: 4),
    year: Faker::Number.within(range: 1990..2020),
    potential: Faker::Number.within(range: 1..5),
    region: Faker::TvShows::Simpsons.location
  )

  puts "Creating 50 bottles for batch #{n + 1}"
  50.times do
    Bottle.create!(
      batch: batch
    )
  end
end

puts "Buying all first batch bottles"
Batch.first.bottles.each do |bottle|
  Transaction.create!(
    user: user1,
    bottle: bottle
  )

  bottle.update!(
    on_resale: true
  )
end

puts "Buying 5 second batch bottles"
Batch.second.bottles.first(5).each do |bottle|
  Transaction.create!(
    user: user1,
    bottle: bottle
  )
end

puts "Finished!"
