require "active_record"

puts "=== DATABASE.RB LOADED ==="
puts "RAILS_ENV: #{ENV['RAILS_ENV']}"
puts "DATABASE_URL present: #{ENV['DATABASE_URL'].present?}"
puts "DATABASE_URL (first 50 chars): #{ENV['DATABASE_URL']&.[](0..50)}..."

ActiveRecord::Base.configurations = {
  "production" => {
    "adapter" => "postgresql",
    "encoding" => "unicode",
    "pool" => ENV.fetch("RAILS_MAX_THREADS") { 5 },
    "url" => ENV["DATABASE_URL"]
  }
}

if ENV["RAILS_ENV"] == "development" || Rails.env.development?
  puts "=== DEVELOPMENT MODE: Using SQLite ==="
  ActiveRecord::Base.configurations["development"] = {
    "adapter" => "sqlite3",
    "database" => "db/development.sqlite3",
    "pool" => 5,
    "timeout" => 5000
  }
  ActiveRecord::Base.establish_connection(:development)
else
  puts "=== PRODUCTION MODE: Using DATABASE_URL ==="
  ActiveRecord::Base.establish_connection(:production)
end

puts "=== DATABASE CONFIGURATION COMPLETE ==="