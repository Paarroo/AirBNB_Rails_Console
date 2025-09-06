# AirBnB Console Helper Methods
module ConsoleHelpers
  # Enhanced display methods for AirBnB models
  
  def pretty_accommodation(accommodation)
    return "No accommodation provided".colorize(:red) unless accommodation
    
    puts "🏠 #{accommodation.title.colorize(:green).bold}"
    puts "   💰 #{accommodation.price_per_night}€/night".colorize(:blue)
    puts "   🛏️  #{accommodation.available_beds} beds"
    puts "   📍 #{accommodation.city&.name || 'No city'}"
    puts "   👤 Host: #{accommodation.host&.full_name || 'No host'}"
    puts "   📝 #{accommodation.description[0..80]}#{'...' if accommodation.description.length > 80}"
    puts "   💬 \"#{accommodation.welcome_message}\"".colorize(:cyan)
    puts "   📅 Created: #{accommodation.created_at.strftime('%d/%m/%Y')}"
    puts
  end
  
  def pretty_user(user)
    return "No user provided".colorize(:red) unless user
    
    puts "👤 #{user.full_name.colorize(:purple).bold}"
    puts "   📧 #{user.email}"
    puts "   📱 #{user.phone_number}"
    puts "   🏠 Hosting: #{user.accommodations.count} accommodations"
    puts "   📅 Reservations made: #{user.reservations.count}"
    puts "   📅 Joined: #{user.created_at.strftime('%d/%m/%Y')}"
    puts
  end
  
  def pretty_reservation(reservation)
    return "No reservation provided".colorize(:red) unless reservation
    
    puts "📅 Reservation ##{reservation.id}".colorize(:blue).bold
    puts "   👤 Guest: #{reservation.guest&.full_name || 'Unknown'}"
    puts "   🏠 Place: #{reservation.accommodation&.title || 'Unknown'}"
    puts "   📅 Check-in: #{reservation.start_date.strftime('%d/%m/%Y')}"
    puts "   📅 Check-out: #{reservation.end_date.strftime('%d/%m/%Y')}"
    duration_days = (reservation.end_date.to_date - reservation.start_date.to_date).to_i
    puts "   📊 Duration: #{duration_days} days"
    
    if reservation.accommodation
      total_price = duration_days * reservation.accommodation.price_per_night
      puts "   💰 Total: #{total_price}€"
    end
    
    puts "   📅 Created: #{reservation.created_at.strftime('%d/%m/%Y')}"
    puts
  end
  
  def pretty_city(city)
    return "No city provided".colorize(:red) unless city
    
    puts "🏙️  #{city.name.colorize(:cyan).bold}"
    puts "   📮 ZIP: #{city.zip_code}"
    puts "   🏠 Accommodations: #{city.accommodations.count}"
    puts
  end
  
  # Quick overview methods
  def airbnb_overview
    puts <<~OVERVIEW.colorize(:yellow)
      
      ╔══════════════════════════════════════════════════════╗
      ║                🏠 AirBnB Overview 📊                  ║
      ╚══════════════════════════════════════════════════════╝
      
    OVERVIEW
    
    [
      { label: "Cities", count: City.count, model: City },
      { label: "Users", count: User.count, model: User },
      { label: "Accommodations", count: Accommodation.count, model: Accommodation },
      { label: "Reservations", count: Reservation.count, model: Reservation }
    ].each do |item|
      color = item[:count] > 0 ? :green : :red
      puts "  #{item[:label].ljust(15)}: #{item[:count].to_s.colorize(color)}"
    end
    
    puts "\n  💡 Try: show_latest_accommodations, show_recent_reservations"
    puts
  end
  
  def show_latest_accommodations(limit = 3)
    puts "\n🏠 Latest Accommodations".colorize(:green).bold
    puts "=" * 30
    
    Accommodation.order(created_at: :desc).limit(limit).each do |accommodation|
      pretty_accommodation(accommodation)
    end
  end
  
  def show_recent_reservations(limit = 3)
    puts "\n📅 Recent Reservations".colorize(:blue).bold
    puts "=" * 25
    
    Reservation.order(created_at: :desc).limit(limit).each do |reservation|
      pretty_reservation(reservation)
    end
  end
  
  def show_cities_stats
    puts "\n🏙️  Cities Statistics".colorize(:cyan).bold
    puts "=" * 25
    
    City.includes(:accommodations).each do |city|
      puts "#{city.name.ljust(15)} | #{city.accommodations.count} accommodations"
    end
    puts
  end
  
  # Fun random data display
  def random_accommodation
    accommodation = Accommodation.order('RANDOM()').first
    if accommodation
      puts "\n🎲 Random Accommodation:".colorize(:yellow).bold
      pretty_accommodation(accommodation)
    else
      puts "No accommodations found. Try: rails db:seed".colorize(:red)
    end
  end
  
  def random_user
    user = User.order('RANDOM()').first
    if user
      puts "\n🎲 Random User:".colorize(:yellow).bold
      pretty_user(user)
    else
      puts "No users found. Try: rails db:seed".colorize(:red)
    end
  end
end

# Include helpers in console sessions
if defined?(Rails::Console)
  include ConsoleHelpers
end