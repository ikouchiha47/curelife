# bookable.rb
module Bookable
  extend ActiveSupport::Concern

  included do
    has_many :bookings, :as => :bookable
  end
end