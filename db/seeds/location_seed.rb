require "csv"

puts "Populating locations"

# CSV.foreach("vendor/Pincode.csv", headers: true) do |row|
	# r = row.to_h
	# p r
	# loc = Location.find_by(zip_code: r["Pincode"], state_code: r["StateName"])
	# if loc.present?
		# loc.update(city: r["Office Name"])
	# else
		# Location.create(city: r["Office Name"], zip_code: r["Pincode"], state_code: r["StateName"])
	# end
# end

locations = [
  {
    "city":"Berhampore",
    "state_code":"West Bengal",
    "zip_code":"742101",
  },
  {
    "city":"Dumdum",
    "state_code":"West Bengal",
    "zip_code":"700074"
  }
]

locations.each do |loc|
  Location.create({
    zip_code: loc["zip_code"],
    state_code: loc["state_code"],
  })
end

puts "Populating success"
