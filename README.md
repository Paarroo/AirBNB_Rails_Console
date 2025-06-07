# 🏠 AirBnb Backend - Accommodation Booking System 🌟

## 📖 Description

🚀 Bign Rails project with advanced relational databases! An accommodation booking system where users can find and reserve perfect places to stay across multiple cities in France. ✈️

## 🛠️ Prerequisites

- Ruby (version 3.0 or higher)
- Rails (version 8.0 or higher)
- SQLite3
- Bundler gem
- Terminal/Command line interface

## 📦 Installation

1. Clone the repository on your local machine
2. Navigate to the project directory
3. Install dependencies:

```bash
bundle install
```

4. Seed the database with sample data:

```bash
rails db:seed
```

## 🎮 How to Use

1. Launch the Rails console to interact with the data:

```bash
rails console
```

2. Examples of what you can do:

   ```ruby
   # Find all accommodations in Paris
   paris = City.find_by(name: "Paris")
   paris.listings

   # Find all users who made reservations
   User.joins(:reservations).distinct

   # See a listing's reservations
   listing = Listing.first
   listing.reservations

   # Create a new reservation
   Reservation.create!(
     start_date: 2.days.from_now,
     end_date: 5.days.from_now,
     listing: Listing.first,
     guest: User.first
   )
   ```

```

## 🔄 Database Relationships Summary

```

City ──┐
└─→ Accommodation ──┐
├─→ Reservation ←── User (Guest)
└─→ User (Host)

```

## 🌱 Seed Data

The seed file creates:

- 20 users with realistic French data
- 10 French cities with valid zip codes
- 50 listings distributed across cities
- Past and future reservations for each listing

## 🔐 Key Validations

- **Email format**: Must be valid email format and unique
- **Phone number**: Must match French phone number regex
- **Dates**: End date must be after start date
- **No overlapping**: Prevents double-booking of the same listing
- **Positive values**: Beds and price must be greater than 0
- **Description length**: Minimum 140 characters for listings

---

**Built with ❤️ and Rails as part of learning advanced database relationships!**

🏠 _"Home is where the heart is, good database design is where the magic happens"_ ✨
```
