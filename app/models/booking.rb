class Booking < ApplicationRecord
  validates :bookable_id, :bookable_type, :doctor_id, :user_id, presence: true
  enum status: [:inprogress, :confirmed, :failed, :refunded, :cancelled]

  belongs_to :user
  belongs_to :doctor
end
