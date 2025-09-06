# 🏠 AirBnb - Accommodation Booking System 🌟



## 📖 Description

🚀 Big Rails project with advanced relational databases! An accommodation booking system where users can find and reserve perfect places to stay across multiple cities in France. ✈️

## 🛠️ Prerequisites

- **Ruby** 3.4.5 (managed with rbenv)
- **Rails** 8.0.2.1 
- **rbenv** for Ruby version management
- SQLite3 database
- Bundler gem
- Terminal/Command line interface

## ⚙️ Ruby Environment Setup

This project uses **rbenv** for Ruby version management (not Homebrew Ruby):

```bash
# Install Ruby 3.4.5 with rbenv
rbenv install 3.4.5
rbenv local 3.4.5

# Verify setup
ruby --version    # Should show: ruby 3.4.5
rails --version   # Should show: Rails 8.0.2.1
```

## 📦 Installation

1. Clone the repository on your local machine
2. Navigate to the project directory
3. Install dependencies:

```bash
bundle install
```

4. Setup the database:

```bash
rails db:create
rails db:migrate
rails db:seed
```

## 🎮 How to Use

### 🖥️ Testing in Terminal

#### Method 1: Rails Console (Interactive)
```bash
rails console
# Or in sandbox mode (changes rolled back on exit):
rails console --sandbox
```

#### Method 2: Rails Runner (One-off commands)
```bash
# Check data counts
rails runner 'puts "Users: #{User.count}, Cities: #{City.count}"'

# Test model relationships
rails runner 'puts User.first&.accommodations&.count || "No data yet"'
```

#### Method 3: Start Rails Server
```bash
rails server
# Visit http://localhost:3000 in your browser
```

### 📊 Console Examples

Once in the console, you can test your models:

   ```ruby
   # Find all accommodations in Paris
   paris = City.find_by(name: "Paris")
   paris.accommodations

   # Find all users who made reservations
   User.joins(:reservations).distinct

   # See an accommodation's reservations
   accommodation = Accommodation.first
   accommodation.reservations

   # Create a new reservation
   Reservation.create!(
     start_date: 2.days.from_now,
     end_date: 5.days.from_now,
     accommodation: Accommodation.first,
     guest: User.first
   )
   ```



## 🔄 Database Relationships Summary

City ──┐
└─→ Accommodation ──┐
├─→ Reservation ←── User (Guest)
└─→ User (Host)

```

## 🌱 Seed Data

The seed file creates:

- 20 users with realistic French data
- 10 French cities with valid zip codes
- 50 accommodations distributed across cities
- Past and future reservations for each listing

## 🔐 Key Validations

- **Email format**: Must be valid email format and unique
- **Phone number**: Must match French phone number regex
- **Dates**: End date must be after start date
- **No overlapping**: Prevents double-booking of the same listing
- **Positive values**: Beds and price must be greater than 0
- **Description length**: Minimum 140 characters for accommodations

## 🔧 Troubleshooting

### Ruby Version Issues
If you get Ruby version conflicts:
```bash
# Check which Ruby you're using
which ruby
ruby --version

# On Mac, hould point to rbenv, not Homebrew:
# ✅ /Users/toto/.rbenv/shims/ruby
# ❌ /opt/homebrew/opt/ruby/bin/ruby

# If wrong Ruby is used, check your PATH and rbenv setup
rbenv versions
rbenv global 3.4.5
```

### Rails Server Won't Start
```bash
# Check if all gems are installed
bundle check

# Create database if needed
rails db:create
rails db:migrate

# Start server
rails server
```

---

**Built with ❤️ and Rails as part of learning advanced database relationships!**

🏠 _"Home is where the heart is, good database design is where the magic happens"_ ✨
