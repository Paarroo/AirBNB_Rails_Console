# Console configuration for enhanced AirBnB development experience
Rails.application.configure do
  # Only configure console enhancements in development
  if Rails.env.development?
    console do
      # Load required gems first
      require 'colorize'
      require 'awesome_print'
      require 'hirb'
      
      # Load our custom console helpers
      require_relative '../../lib/console_helpers'
      extend ConsoleHelpers
      
      # Configure AwesomePrint for beautiful object output
      AwesomePrint.defaults = {
        indent: 2,
        index: false,
        color: {
          hash:       :blue,
          class:      :yellow,
          method:     :purple,
          string:     :green,
          symbol:     :cyan,
          numeric:    :red,
          nilclass:   :gray
        }
      }
      
      # Configure Hirb for table formatting
      Hirb.enable
      
      # Enable Hirb for ActiveRecord models
      extend Module.new {
        def disable_hirb
          Hirb.disable
        end
        
        def enable_hirb
          Hirb.enable
        end
      }
      
      puts <<-BANNER.colorize(:cyan)
╔══════════════════════════════════════════════════════════════════╗
║                    🏠 AirBnB Console Ready! 🌟                    ║
║                                                                  ║
║  Enhanced with: awesome_print, hirb, pry, colorize             ║
║                                                                  ║
║  Quick commands:                                                 ║
║    > airbnb_overview           # Full AirBnB statistics        ║
║    > show_latest_accommodations # Show newest places           ║
║    > show_recent_reservations  # Show latest bookings          ║
║    > random_accommodation      # Display random place          ║
║    > random_user              # Display random user            ║
║    > show_cities_stats        # Cities overview                ║
║                                                                  ║
║  Try: User.first or pretty_accommodation(Accommodation.first)   ║
╚══════════════════════════════════════════════════════════════════╝
BANNER

      # Welcome message
      puts "Console ready! Type 'airbnb_overview' to see your data 🚀".colorize(:green)
    end
  end
end