require 'faker'

puts "Doctors seed"

location_ids = Location.all.pluck(:id)
speciality_ids = Speciality.all.pluck(:id)

(0..7).each do |_|
  Doctor.create!({
    name: Faker::Name.name,
    email: Faker::Internet.email,
    location_ids: location_ids.sample(2).join(","),
    speciality_ids: speciality_ids.sample,
    registration_number: Faker::IDNumber.valid,
  })
end

puts "Doctor seed success"
