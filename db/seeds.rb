# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "faker"
puts "Deleting previous data..."
User.delete_all
Property.delete_all
Interaction.delete_all
puts "Database cleared."
ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('properties')
ActiveRecord::Base.connection.reset_pk_sequence!('interactions')
puts "Reseted ids"
puts "Seeding users..."
5.times do |index|
    user = User.new(email: "user#{index}@gmail.com",
                  name: Faker::Internet.unique.username(specifier:(1..16)),
                  password: "#{Faker::Internet.password(min_length: 6)}#{rand(1..9)}",
                  phone: Faker::PhoneNumber.cell_phone,
                  type_user:"#{index.even? ? "Landlord" : "HomeSeeker"}")
  # user.avatar.attach(io: URI.open(Faker::Avatar.unique.image(size: "100x100", format: "jpg")), filename: "#{index}.jpg")
  p user.errors.full_messages unless user.save
  # tweet = Tweet.create(body: Faker::Quote.unique.famous_last_words, user_id: user.id)
end
puts "Seeding of 5 properties"

 User.all.each do |user1|
   if user1.type_user == "Landlord"
    2.times do |index|

      property = Property.new(operation_type:"#{index.even? ? "Rent" : "Sale"}",
                              location: Faker::Address.full_address,
                              price: rand(500..1500),
                              property_type:"#{index.even? ? "House" : "Aparment"}",
                              maintanance: rand(100..300),
                              bathroom: Faker::Number.number(digits:1),
                              petfriendly: Faker::Boolean.boolean,
                              bedroom:Faker::Number.number(digits:1),
                              area: Faker::Number.number(digits:3),
                              description: Faker::Lorem.sentence(word_count: 10),
                              user_id: user1.id
      )
      p property.errors.full_messages unless property.save

    end
   end

 end

puts "Properties created"

puts "Seeding interactions..."

5.times do |index|
  interaction = Interaction.new(user_id: User.where(id: User.ids.sample).ids[0],
                                property_id: Property.where(id: Property.ids.sample).ids[0],
                                favorite: Faker::Boolean.boolean,
                                contacted: Faker::Boolean.boolean,
                                actived: Faker::Boolean.boolean,
                                closed: Faker::Boolean.boolean
                                )
  p interaction.errors.full_messages unless interaction.save
end

puts "Interactions created"
