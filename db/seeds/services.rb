puts 'Populating location services'

locations = Location.all
services = Service.all

locations.each do |loc|
  LocationService.create!(
    location_id: loc.id,
    services: services.sample(rand(1..services.length))
  )
end
