# 🏠 AirBnb Backend - Enhanced Console Experience 🌟

## 📖 Description

🚀 Advanced Rails project with enhanced developer console experience! An accommodation booking system where users can find and reserve perfect places to stay across multiple cities in France. ✈️

**✨ Features beautiful colorized console output, helpful debug methods, and enhanced model display for optimal development experience.**

## 🛠️ Prerequisites

- Ruby 3.4.5 (specified in .ruby-version)

- Rails 8.0.2.1

- SQLite3

- Bundler gem

- Terminal with Unicode and color support

## 📦 Installation

1.  Clone the repository on your local machine

2.  Navigate to the project directory

3.  Install dependencies:

bundle install

4.  Seed the database with sample data:

rails db:seed

## 🎨 Enhanced Console Features

- **Welcome Banner** with ASCII art when starting console

- **Enhanced Gems**: awesome_print, colorize, hirb, pry-rails, better_errors

- **Helper Methods**: `airbnb_overview`, `pretty_accommodation()`, `pretty_user()`, `pretty_reservation()`

- **Colorized Output**: All models display with colors and emojis

## 🎮 Usage

rails console
​

# Try these enhanced commands:

airbnb_overview
pretty_accommodation(Accommodation.first)
pretty_user(User.first)
​

# Standard queries with colorized output

Accommodation.limit(3)
User.where("email LIKE '%gmail%'")

## 🔄 Database Relationships Summary

```text
City ──┐
       └─→ Accommodation ──┐
                           ├─→ Reservation ←── User (Guest)
                           └─→ User (Host)

Relationships:
• City has many Accommodations
• Accommodation belongs to City & User (Host)  
• Reservation belongs to Accommodation & User (Guest)
• User can be Host (owns accommodations) or Guest (makes reservations)
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

---

**Built with ❤️ and Rails featuring enhanced developer experience!**

🏠 _"Home is where the heart is, beautiful console output is where the productivity happens"_ ✨
