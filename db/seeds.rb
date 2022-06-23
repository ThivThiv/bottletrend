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

Transaction.destroy_all
Bottle.destroy_all
Domain.destroy_all
Batch.destroy_all
User.destroy_all

puts 'Creating user 1'
user1 = User.create!(
  email: 'user1@gmail.com',
  password: 'password',
  balance: 10000
)

puts 'Creating user 2'
user2 = User.create!(
  email: 'user2@gmail.com',
  password: 'password',
  balance: 10000
)

puts 'Creating user 3'
user3 = User.create!(
  email: 'user3@gmail.com',
  password: 'password',
  balance: 10000
)

puts 'Creating user Bottle'
user4 = User.create!(
  email: 'bottle@gmail.com',
  password: 'password',
  balance: 3000
)

puts "Creating domains Malartic Lagraviere..."
file = URI.open('https://res.cloudinary.com/messa57fr/image/upload/v1655376345/domain-chateau-lamartic_aspzoe.jpg')
malartic = Domain.new(
  year: 1889,
  name: "Château Malartic-Lagravière",
  description: "Jouissant d’une grande réputation depuis le début du siècle dernier, le Château Malartic-Lagravière est un des seuls six crus classés à la fois en blanc et en rouge lors du classement des Graves de 1953.
  Depuis sa création au XVIII° Siècle, seulement quatre familles se sont succédées à Malartic. Le goût de l’aventure coule toujours dans les veines des hommes et des femmes en charge de sa destinée.",
  popularity: 4
)
malartic.photo.attach(io: file, filename: "domain-chateau-lamartic.jpg", content_type: 'image/jpg')
malartic.save

puts "Creating domains Chateau Latour..."
file = URI.open('https://res.cloudinary.com/messa57fr/image/upload/v1655376340/domaine-chateau-latour_ctp4s1.webp')
latour = Domain.new(
  year: 1331,
  name: "Château Latour",
  description: "Le domaine de Château Latour a été au cœur de l’histoire de sa région et la connaissance du passé nous est précieuse pour mieux comprendre aujourd’hui l’origine de la renommée de la Propriété. La présence d’archives importantes conservées au fil des siècles nous permet d’effectuer ce voyage dans le temps avec suffisamment de précision. Cet héritage unique nous montre une extraordinaire stabilité et une vraie continuité dans la vie de la propriété et de ses artisans au fil des siècles expliquant ainsi en partie la grande régularité dans la qualité des vins.",
  popularity: 5
)
latour.photo.attach(io: file, filename: "domain-chateau-latour.webp", content_type: 'image/webp')
latour.save

puts "Creating domains Chateau Margaux..."
file = URI.open('https://res.cloudinary.com/messa57fr/image/upload/v1655376517/chateau-margaux_l8ob5z.jpg')
margaux = Domain.new(
  year: 1500,
  name: "Château Margaux",
  description: "En ce début de XXIème siècle, les vins de Bordeaux connaissent un succès sans précédent. Le monde entier semble avoir les yeux rivés sur Bordeaux et la demande ne cesse de croître. Cette prospérité ainsi que l’essor de nombreuses autres régions du monde ont placé Château Margaux dans un climat plus concurrentiel et ont aussi permis d’en souligner le positionnement unique : celui d’un Premier Grand Cru Classé en 1855 jouissant d’un terroir façonné au fil des siècles.  ",
  popularity: 5
)
margaux.photo.attach(io: file, filename: "domain-chateau-margaux.jpg", content_type: 'image/jpg')
margaux.save

puts "Creating domains Chateau Margaux..."
file = URI.open('https://res.cloudinary.com/messa57fr/image/upload/v1655999258/Img1_MAGREZ_CORPO_GRAND_CRU_PapeClement-min_otemkg.jpg')
clement = Domain.new(
  year: 1252,
  name: "Château Pape Clément",
  description: "Proche de Bordeaux, partez à la découverte des 7 siècles d’histoire d’un Grand Cru Classé mythique des Graves entouré de vignes et doté d’un somptueux jardin. Un château unique dont les premières vendanges ont été effectuées en 1252."
  popularity: 5
)
clement.photo.attach(io: file, filename: "domain-chateau-pape-clement.jpg", content_type: 'image/jpg')
clement.save



puts "Creating batch Chateau Malartic Lagraviere"
file = URI.open('https://res.cloudinary.com/messa57fr/image/upload/v1655376350/mlr2019_oci28o.png')
b1 = Batch.new(
  name: "Château Malartic Lagraviere",
  quantity: 60,
  initial_price: 130,
  domain: malartic,
  description: "La robe : magnifique robe rouge intense et resplendissante
  Le nez : on retrouve des arômes fruités, légèrement boisé, ainsi que des épices et du tabac blond
  La bouche : une belle attaque souple et fruitée, charnu, épicé, persistante et des tannins fondus.",
  year: 2018,
  potential: 4,
  region: "Bordeaux"
)
b1.photo.attach(io: file, filename: "bottle-chateau-lamartic.jpg", content_type: 'image/png')
b1.save

puts "Creating batch Les Forts de Latour"
file = URI.open("https://res.cloudinary.com/messa57fr/image/upload/v1655382871/chateau-latour_yyp9qe.png")
b2 = Batch.new(
  name: "Les Forts de Latour",
  quantity: 40,
  initial_price: 180,
  domain: latour,
  description: "Voici une merveilleuse introduction aux vins du légendaire Château Latour. Affichant une robe d’un rubis intense, le nez est fruité, frais et mûr sur fond de pivoine et d’épices. ",
  year: 2015,
  potential: 4,
  region: "Bordeaux"
)
b2.photo.attach(io: file, filename: "bottle-les-forts-de-latour.jpg", content_type: 'image/png')
b2.save

puts "Creating batch Pauillac"
file = URI.open("https://res.cloudinary.com/messa57fr/image/upload/v1655383298/1frbor0043553_g74mq0.jpg")
b3 = Batch.new(
  name: "Pauillac",
  quantity: 100,
  initial_price: 90,
  domain: latour,
  description: "Le premier millésime de ce vin voit le jour en 1989 avec l'objectif de proposer une approche plus accessible du Château Latour. Il est élaboré avec les raisins des jeunes vignes du domaine. Toutes les étapes de fabrication sont dirigées avec soin. Il est élevé en fût pendant 1 an environ avec un renouvellement en bois neuf de 20%. Il est recommandé de le garder au moins 5 ans en bouteille avant dégustation.",
  year: 2017,
  potential: 3,
  region: "Bordeaux"
)
b3.photo.attach(io: file, filename: "bottle-pauillac.jpg", content_type: 'image/png')
b3.save

puts "Creating batch Chateau Margaux"
file = URI.open("https://res.cloudinary.com/messa57fr/image/upload/v1655383734/chateau-margaux-2017-1er-cru-classe_bkszcq.png")
b4 = Batch.new(
  name: "Chateau Margaux",
  quantity: 60,
  initial_price: 125,
  domain: margaux,
  description: "Dominant sans grand mal toute l’appellation Margaux et d'une remarquable constance, Château Margaux produit des vins devenus mythiques tant le mariage rare de la finesse dans la densité, et de la fraîcheur dans l’opulence est réussi.",
  year: 2017,
  potential: 3,
  region: "Bordeaux"
)
b4.photo.attach(io: file, filename: "bottle-chateau-margaux.jpg", content_type: 'image/png')
b4.save

puts "Creating batch Chassagne Montrachet"
file = URI.open("https://res.cloudinary.com/messa57fr/image/upload/v1655998313/chassagne-montrachet-rouge-2019-louis-latour_eilggs.png")
b5 = Batch.new(
  name: "Château Chassagne Montrachet",
  quantity: 60,
  initial_price: 125,
  domain: margaux,
  description: "Dominant sans grand mal toute l’appellation Margaux et d'une remarquable constance, Château Margaux produit des vins devenus mythiques tant le mariage rare de la finesse dans la densité, et de la fraîcheur dans l’opulence est réussi.",
  year: 2009,
  potential: 3,
  region: "Bourgogne"
)
b5.photo.attach(io: file, filename: "bottle-chassagne-montrachet.jpg", content_type: 'image/png')
b5.save

puts "Creating batch Chateau Pape Clement 2018"
file = URI.open("https://res.cloudinary.com/messa57fr/image/upload/v1655999354/chateau-pape-clement-2004-grand-cru-classe_xple6e.png")
b6 = Batch.new(
  name: "Château Pape Clement",
  quantity: 60,
  initial_price: 99,
  domain: margaux,
  description: "Un très grand millésime ! Un des plus beaux châteaux de Pessac-Léognan. D'une qualité admirable ce vin est à la fois concentré, fin et harmonieux, présentant une palette aromatique aussi large que précise",
  year: 2018,
  potential: 4,
  region: "Bordeau"
)
b6.photo.attach(io: file, filename: "bottle-chassagne-montrachet.jpg", content_type: 'image/png')
b6.save

users = [user1, user2, user3]
57.times do
  b = Bottle.new()
  batch = Batch.find_by_name("Chateau Malartic Lagraviere")
  if batch.available_domain_stock > 0
    b.batch = batch
    b.created_at = rand((DateTime.now - 3.months)..DateTime.now)
    b.save!
    t = Transaction.new
    t.bottle = b
    t.user = users[0]
    t.save!
  end
end

batch = Batch.find_by_name("Les Forts de Latour")
batch.available_domain_stock.times do
  b = Bottle.new
  b.batch = batch
  b.created_at = rand((DateTime.now - 3.months)..DateTime.now)
  b.save!
  t = Transaction.new
  t.bottle = b
  t.user = users[1]
  t.save!
end

Batch.find_by_name("Les Forts de Latour").bottles.last(5).map(&:last_transaction).each do |transaction|
  transaction.on_resale = true
  transaction.save
end

puts "Finished!"
