class LabTestBooking < ApplicationRecord
  include Bookable

  scope :active, ->{ where('expires_at > ?', DateTime.now)}
end
