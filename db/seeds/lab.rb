require 'faker'

puts "Lab seed"

location_ids = Location.all.pluck(:id)

(0..10).each do |_|
  Lab.create!({
    name: Faker::Company.name,
    registration_number: Faker::Company.norwegian_organisation_number,
    address: Faker::Address.full_address,
    location_id: location_ids.sample,
  })
end

puts "Lab seed success"
