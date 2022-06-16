# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require "open-uri"

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

puts 'Creating user 2'
user1 = User.create!(
  email: 'user2@gmail.com',
  password: 'password'
)

puts 'Creating user 3'
user1 = User.create!(
  email: 'user3@gmail.com',
  password: 'password'
)

puts "Creating domains Malartic Lagraviere..."
file = URI.open('https://res.cloudinary.com/messa57fr/image/upload/v1655376345/domain-chateau-lamartic_aspzoe.jpg')
d = Domain.new(
  year: 1889,
  name: "Château Malartic-Lagravière",
  description: "Jouissant d’une grande réputation depuis le début du siècle dernier, le Château Malartic-Lagravière est un des seuls six crus classés à la fois en blanc et en rouge lors du classement des Graves de 1953.
  Depuis sa création au XVIII° Siècle, seulement quatre familles se sont succédées à Malartic. Le goût de l’aventure coule toujours dans les veines des hommes et des femmes en charge de sa destinée.",
  popularity: 4
)
d.photo.attach(io: file, filename: "domain-chateau-lamartic.jpg", content_type: 'image/jpg')
d.save

puts "Creating domains Chateau Latour..."
file = URI.open('https://res.cloudinary.com/messa57fr/image/upload/v1655376340/domaine-chateau-latour_ctp4s1.webp')
d = Domain.new(
  year: 1331,
  name: "Chateau Latour",
  description: "Le domaine de Château Latour a été au cœur de l’histoire de sa région et la connaissance du passé nous est précieuse pour mieux comprendre aujourd’hui l’origine de la renommée de la Propriété. La présence d’archives importantes conservées au fil des siècles nous permet d’effectuer ce voyage dans le temps avec suffisamment de précision. Cet héritage unique nous montre une extraordinaire stabilité et une vraie continuité dans la vie de la propriété et de ses artisans au fil des siècles expliquant ainsi en partie la grande régularité dans la qualité des vins.",
  popularity: 5
)
d.photo.attach(io: file, filename: "domain-chateau-latour.webp", content_type: 'image/webp')
d.save




# (0..4).each do |n|
#   puts "Creating batch #{n + 1}"
#   batch = Batch.create!(
#     name: Faker::Artist.name,
#     quantity: Faker::Number.within(range: 100..300),
#     initial_price: Faker::Number.number(digits: 3),
#     domain: Domain.last,
#     description: Faker::Lorem.paragraph(sentence_count: 4),
#     year: Faker::Number.within(range: 1990..2020),
#     potential: Faker::Number.within(range: 1..5),
#     region: Faker::TvShows::Simpsons.location
#   )

#   puts "Creating 50 bottles for batch #{n + 1}"
#   50.times do
#     Bottle.create!(
#       batch: batch
#     )
#   end
# end

# puts "Buying all first batch bottles"
# Batch.first.bottles.each do |bottle|
#   Transaction.create!(
#     user: user1,
#     bottle: bottle
#   )

#   bottle.update!(
#     on_resale: true
#   )
# end

# puts "Buying 5 second batch bottles"
# Batch.second.bottles.first(5).each do |bottle|
#   Transaction.create!(
#     user: user1,
#     bottle: bottle
#   )
# end

puts "Finished!"
