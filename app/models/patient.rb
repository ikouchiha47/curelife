class Patient < User
	validates :name, :phone, :country_code, presence: true
	validates :country_code, numericality: {in: 0..999}
	validates_format_of :phone, :with => /[0-9]{10,}/
end