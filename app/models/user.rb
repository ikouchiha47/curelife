class User < ApplicationRecord
  has_secure_password

  validates :password, presence: true, on: :create
  has_many :bookings

  def authentic?(password)
    self.blocked == false && self.authenticate(password)
  end

  def full_name
    "#{salutiation}, #{name}"
  end

  def booking
    Booking.where(user_id: id, status: :inprogress).order(created_at: :desc).limit(1).first
  end

end
