class Doctor < ApplicationRecord
	has_secure_password
    attr_accessor :locations, :specialities

	validates :password, presence: true, on: :create
	# validates :name, :phone, :country_code, presence: true

	validates :country_code, numericality: {in: 0..999}, allow_blank: true
	validates_format_of :phone, :with => /[0-9]{10,}/, allow_blank: true

    validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
    validates :registration_number, presence: true, uniqueness: true

    before_save do
      self.location_ids = serialize_array(locations || [])
      self.speciality_ids = serialize_array(specialities || [])
    end

    def self.at_locations(location_ids)
      where("location_ids LIKE '%?%'", location_ids.join(","))
    end

    def locations_to_a
      location_ids.gsub(/[{}]/, '').split(',')
    end

    def specialities_to_a
      speciality_ids.gsub(/[{}]/, '').split(',')
    end

    private

      def serialize_array(array)
        "{#{array.join(",")}}"
      end
end
