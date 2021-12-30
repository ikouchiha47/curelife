require "csv"

puts "Populating locations"

CSV.foreach("vendor/Pincode.csv", headers: true) do |row|
	r = row.to_h
	p r
	loc = Location.find_by(zip_code: r["Pincode"], state_code: r["StateName"])
	if loc.present?
		loc.update(city: r["Office Name"])
	else
		Location.create(city: r["Office Name"], zip_code: r["Pincode"], state_code: r["StateName"])
	end
end

puts "Populating success"