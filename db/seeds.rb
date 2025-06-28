require 'faker'
require 'date'

Faker::Config.locale = 'fr'

puts "Suppression des anciennes données..."

Reservation.destroy_all
Listing.destroy_all
City.destroy_all
User.destroy_all

puts "Création de 20 utilisateurs..."

20.times do |i|
    email = Faker::Internet.email
    phone = "06" + rand(10000000..99999999).to_s  # génère un numéro comme 06XXXXXXXX
    description = Faker::Lorem.sentence(word_count: 10)
    User.create!(
        email: email,
        phone_number: phone,
        description: description

  )
end

puts "Création de 10 villes..."

10.times do |i|
    zip_code = "%05d" % rand(0..95999)   # génère un code postal à 5 chiffres
    name = "Ville#{i + 1}"         # génère un nom de ville simple : Ville1, Ville2, ...  
    City.create!(
        name: name,
        zip_code: zip_code
  )
end

puts "Création de 50 listings..."

50.times do |i|
    available_beds = rand(1..10)
    price = rand(50..500)
    description = Faker::Lorem.paragraph_by_chars(number: 140)
    has_wifi = [true, false].sample
    welcome_message = "Bienvenue et bon séjour chez nous !"
    city = City.all.sample

    Listing.create!(
        available_beds: available_beds,
        price: price,
        description: description,
        has_wifi: has_wifi,
        welcome_message: welcome_message,
        city: city
    )
end

puts "\nRéservation passée :"

5.times do |i|
    # On choisit un début entre 60 et 10 jours avant aujourd’hui
    start_date = Date.today - rand(10..60)
    # Et une fin entre 1 et 7 jours après le début
    end_date = start_date + rand(1..7)
    guest = User.all.sample
    listing = Listing.all.sample

    Reservation.create!(
        start_date: start_date,
        end_date: end_date,
        guest: guest,
        listing: listing
  )
  
  puts "Réservation #{i + 1} : du #{start_date} au #{end_date}"
end

puts "\nRéservation future :"

    # Date future, entre 3 et 10 jours après aujourd’hui
    start_date = Date.today + rand(3..10)
    # Fin entre 1 et 7 jours après
    end_date = start_date + rand(1..7)
    guest = User.all.sample
    listing = Listing.all.sample

    Reservation.create!(
        start_date: start_date,
        end_date: end_date,
        guest: guest,
        listing: listing
)

puts "Réservation future : du #{start_date} au #{end_date}"

puts "Seed terminé !"
