puts "Populating specialities"

[
  "Orthopedics",
  "Internal Medicine",
  "Dermatology",
  "Pediatrics",
  "General Surgery",
  "Cardiology",
  "Anasthesia"
].each do |s|
  Speciality.create!(name: s)
end

puts "Populating success"
