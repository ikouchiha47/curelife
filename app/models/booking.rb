class Booking < ApplicationRecord
	belongs_to :user, foreign_key: :patient_id
	belongs_to :bookable, polymorphic: true
end
