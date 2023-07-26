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
6.times do |index|
    user = User.new(email: "user#{index}@gmail.com",
                  name: Faker::Internet.unique.username(specifier:(1..16)),
                  password: "#{Faker::Internet.password(min_length: 6)}#{rand(1..9)}",
                  phone: Faker::PhoneNumber.cell_phone,
                  type_user:"#{index.even? ? "Landlord" : "HomeSeeker"}")
  # user.avatar.attach(io: URI.open(Faker::Avatar.unique.image(size: "100x100", format: "jpg")), filename: "#{index}.jpg")
  p user.errors.full_messages unless user.save
  # tweet = Tweet.create(body: Faker::Quote.unique.famous_last_words, user_id: user.id)
end
puts "Seeding user general..."
user1 = User.new(email:"code@able.com",name:"Rossi",password:"123456MERe3",phone:"98764353",type_user:"Landlord")
p user1.errors.full_messages unless user1.save
puts "Seeding of 5 properties"

k = 0
array_coordenadas =[['-12.117979','-77.031427','C. 2 de Mayo 316, Miraflores 15074'],['-12.116426', '-77.038079','Ca. Gral. Miguel Iglesias 300-402, Miraflores 15074'],['-12.114952', '-77.042789','Av. Gral. Córdova 190-294, Miraflores 15073'],['-12.114566', '-77.047011','C. Ignacio Merino 318, Miraflores 15074']]
 User.all.each do |user1|
   if user1.type_user == "Landlord"
    2.times do |index|
      k = k +1
      property = Property.new(operation_type:"#{index.even? ? "Rent" : "Sale"}",
                              location: array_coordenadas[(k-1)/2],
                              price: rand(500..1500),
                              property_type:"#{index.even? ? "House" : "Aparment"}",
                              maintanance: rand(100..300),
                              bathroom: Faker::Number.number(digits:1),
                              petfriendly: Faker::Boolean.boolean,
                              bedroom:Faker::Number.number(digits:1),
                              area: Faker::Number.number(digits:3),
                              description: Faker::Lorem.sentence(word_count: 10),
                              user_id: user1.id,
                              name_image: ["propiedad#{k}.jpg"]
      )
      p property.errors.full_messages unless property.save
    end
   end

 end

puts "Properties created"

puts "Seeding interactions..."

8.times do |index|
  a = index%2==0? index+1 : index
  interaction1 = Interaction.new(user_id: a,
                                property_id: index + 1,
                                actived: true,
                                closed: false
                                )                             
  interaction2 = Interaction.new(user_id: User.where(id: User.ids.sample).ids[0],
                                property_id: Property.where(id: Property.ids.sample).ids[0],
                                favorite: Faker::Boolean.boolean,
                                contacted: Faker::Boolean.boolean
                                )
  p interaction1.errors.full_messages unless interaction1.save
  p interaction2.errors.full_messages unless interaction2.save
end

puts "Interactions created"
