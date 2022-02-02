class Location < ApplicationRecord
  DEFAULT_ZIP_CODES = [
    Location.new(city: "Berhampore", zip_code: "742101"),
    Location.new(city: "Kolkata", zip_code: "700074")
  ]
end
