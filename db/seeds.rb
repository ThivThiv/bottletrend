# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Cleaning database..."

Batch.destroy_all
Bottle.destroy_all
Domain.destroy_all
Transaction.destroy_all
User.destroy_all

puts "Creating 4 batches..."
(0..4).each do
  Batch.create(
    quantity: Faker::Number.within(range: 100..300),
    initial_price: Faker::Number.number(digits: 3),
    domain_id: Faker::Number.within(range: 1..20),
    description: Faker::Lorem.paragraph(sentence_count: 4),
    year: Faker::Number.within(range: 1990..2020),
    potential: Faker::Number.within(range: 1..5),
    region: Faker::TvShows::Simpsons.location
  )
end

puts "Creating 200 bottles..."
(0..200).each do
  Bottle.create(
    batch_id: Faker::Number.within(range: 1..5)
  )
end

puts "Creating 4 domains..."
(0..4).each do
  Domain.create(
    year: Faker::Number.within(range: 1880..1980),
    name: Faker::Movie.quote,
    description: Faker::Lorem.paragraph(sentence_count: 4),
    popularity: Faker::Number.within(range: 1..5),
  )
end

puts "Creating 100 transactions..."
(0..100).each do
  Transaction.create(
    quantity: Faker::Number.within(range: 1..2),
    user_id: Faker::Number.within(range: 1..50),
    bottle_id: Faker::Number.within(range: 1..200),
    price: Faker::Number.number(digits: 4),
  )
end

puts "Creating 50 users..."
(0..50).each do
  User.create(
    email: Faker::Internet.email,
    first_name: Faker::Name.unique.name,
    last_name: Faker::Name.unique.name,
    seller: false,
    balance: Faker::Number.number(digits: 4),
  )
end

puts "Finished!"


# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_06_14_125711) do

  # These are extensions that must be enabled in order to support this database
end
