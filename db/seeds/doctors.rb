require 'faker'

puts "Doctors seed"

location_ids = Location.all.pluck(:id)
speciality_ids = Speciality.all.pluck(:id)

(0..7).each do |_|
  Doctor.create!({
    salutation: "Dr",
    birthdate: Faker::Date.birthday(min_age: 25, max_age: 65),
    name: Faker::Name.name,
    email: Faker::Internet.email,
    locations: location_ids.sample(rand(1..2)),
    specialities: [speciality_ids.sample],
    registration_number: Faker::IDNumber.valid,
    password: 'abcd1234',
    password_confirmation: 'abcd1234'
  })
end

puts "Doctor seed success"
