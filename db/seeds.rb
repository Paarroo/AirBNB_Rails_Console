# db/seeds.rb

puts "🗑️  Destruction de la base de données actuelle..."

# Supprimer les données
Reservation.delete_all
Accommodation.delete_all
User.delete_all
City.delete_all

# Remettre tous les compteurs à zéro
ActiveRecord::Base.connection.execute("UPDATE sqlite_sequence SET seq = 0")

puts "✅ Base de données vidée et compteurs remis à zéro"

puts "👤 Création de 20 utilisateurs..."
users = []
20.times do |i|
  user = User.create!(
    email: "user#{i + 1}@example.com",
    phone: "0#{rand(1..9)}#{rand(10..99)}#{rand(10..99)}#{rand(10..99)}#{rand(10..99)}"
  )
  users << user
  print "."
end
puts "\n✅ #{User.count} utilisateurs créés"

puts "🏙️  Création de 10 villes..."
french_cities = [
  { name: "Paris", zip_code: "75001" },
  { name: "Lyon", zip_code: "69001" },
  { name: "Marseille", zip_code: "13001" },
  { name: "Toulouse", zip_code: "31000" },
  { name: "Nice", zip_code: "06000" },
  { name: "Nantes", zip_code: "44000" },
  { name: "Strasbourg", zip_code: "67000" },
  { name: "Montpellier", zip_code: "34000" },
  { name: "Bordeaux", zip_code: "33000" },
  { name: "Lille", zip_code: "59000" }
]

cities = []
french_cities.each do |city_data|
  city = City.create!(city_data)
  cities << city
  print "."
end
puts "\n✅ #{City.count} villes créées"

puts "🏠 Création de 50 logements..."
accommodations = []
wifi_options = [ true, false ]
descriptions = [
  "Magnifique appartement au cœur de la ville avec une vue imprenable. Parfait pour un séjour romantique ou d'affaires. Proche de tous les transports en commun.",
  "Charmante maison avec jardin privé, idéale pour les familles. Quartier calme et résidentiel. Toutes les commodités à proximité pour un séjour agréable.",
  "Studio moderne et équipé dans un quartier branché. Parfait pour les jeunes voyageurs. Wifi haut débit et cuisine équipée pour votre confort.",
  "Appartement spacieux avec balcon et vue sur les monuments historiques. Décoré avec goût, il vous offrira un séjour inoubliable en plein centre-ville.",
  "Loft atypique dans un bâtiment rénové. Ambiance industrielle et moderne. Idéal pour découvrir la ville à pied. Nombreux restaurants à proximité."
]

welcome_messages = [
  "Bienvenue dans notre logement ! Nous espérons que vous passerez un excellent séjour. N'hésitez pas à nous contacter pour toute question.",
  "Nous sommes ravis de vous accueillir ! Vous trouverez toutes les informations nécessaires dans le livret d'accueil. Bon séjour !",
  "Welcome home ! Profitez de votre séjour et découvrez tous les secrets de notre belle ville. Nous restons à votre disposition.",
  "Cher voyageur, bienvenue ! Ce logement a été préparé avec soin pour votre confort. Passez un merveilleux séjour parmi nous.",
  "Bonjour et bienvenue ! Nous espérons que ce lieu vous plaira autant qu'à nous. Explorez, détendez-vous et créez de beaux souvenirs !"
]

50.times do |i|
  accommodation = Accommodation.create!(
    available_beds: rand(1..8),
    price: rand(30..300),
    description: descriptions.sample,
    has_wifi: wifi_options.sample,
    welcome_message: welcome_messages.sample,
    owner: users.sample,
    city: cities.sample
  )
  accommodations << accommodation
  print "."
end
puts "\n✅ #{Accommodation.count} logements créés"

puts "📅 Création des réservations..."
total_reservations = 0

accommodations.each_with_index do |accommodation, index|
  print "Logement #{index + 1}/50: "

  # Créer des créneaux de dates non-chevauchants
  past_reservations = []
  future_reservations = []

  # 5 réservations dans le passé (espacées de 2 semaines minimum)
  current_date = 6.months.ago
  5.times do |i|
    start_date = current_date + (i * 3.weeks) + rand(0..7).days
    duration = rand(1..7).days
    end_date = start_date + duration

    # S'assurer qu'on reste dans le passé
    if end_date < 1.week.ago
      reservation = Reservation.create!(
        start_date: start_date,
        end_date: end_date,
        guest: users.sample,
        accommodation: accommodation
      )
      past_reservations << reservation
      total_reservations += 1
    end
  end

  # 5 réservations dans le futur (espacées de 2 semaines minimum)
  current_date = 2.weeks.from_now
  5.times do |i|
    start_date = current_date + (i * 3.weeks) + rand(0..7).days
    duration = rand(1..7).days
    end_date = start_date + duration

    # S'assurer qu'on reste dans les 6 mois
    if start_date < 6.months.from_now
      reservation = Reservation.create!(
        start_date: start_date,
        end_date: end_date,
        guest: users.sample,
        accommodation: accommodation
      )
      future_reservations << reservation
      total_reservations += 1
    end
  end

  print "✓ (#{past_reservations.length + future_reservations.length} réservations) "
end

puts "\n✅ #{total_reservations} réservations créées"

puts "\n" + "="*50
puts "🎉 SEED TERMINÉ AVEC SUCCÈS !"
puts "="*50
puts "📊 Résumé :"
puts "   👤 Utilisateurs : #{User.count}"
puts "   🏙️  Villes : #{City.count}"
puts "   🏠 Logements : #{Accommodation.count}"
puts "   📅 Réservations : #{Reservation.count}"
puts "   📅 Réservations passées : #{Reservation.where('end_date < ?', Date.current).count}"
puts "   📅 Réservations futures : #{Reservation.where('start_date > ?', Date.current).count}"
puts "="*50

puts "\n🔍 Quelques exemples :"
puts "\n📍 Première ville : #{City.first.name} (#{City.first.zip_code})"
puts "👤 Premier utilisateur : #{User.first.email}"
puts "🏠 Premier logement : #{Accommodation.first.city.name} - #{Accommodation.first.available_beds} lits - #{Accommodation.first.price}€/nuit"
puts "📅 Première réservation : du #{Reservation.first.start_date.strftime('%d/%m/%Y')} au #{Reservation.first.end_date.strftime('%d/%m/%Y')}"
