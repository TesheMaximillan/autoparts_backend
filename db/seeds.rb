# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Seeding Start

puts "[db/seeds.rb] Seeding data..."
User.create!([
               {username: "teshe", full_name: "Teshome Kurabachew", email: "teshe@gmail.com", password: "password", password_confirmation: "password"},
               {username: "sinte", full_name: "Sintayehu", email: "sinte@gmail.com", password: "password", password_confirmation: "password"}
             ])

Stock.create!([
                {name: "Shop"},
                {name: "Store"}
              ])

Category.create!([
                   {name: "Fuel Filter"},
                   {name: "Oil Filter"}
                 ])

Customer.create!([
                   {name: "customer1"},
                   {name: "customer2"}
                 ])

Vendor.create!([
                 {name: "vendor1"},
                 {name: "vendor2"}
               ])

puts "[db/seeds.rb] Seeding data...done"
