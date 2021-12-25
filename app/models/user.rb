class User < ApplicationRecord
	has_secure_password

	validates :password, presence: true
	has_many :bookings
end
