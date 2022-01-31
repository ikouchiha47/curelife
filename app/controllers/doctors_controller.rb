class DoctorsController < ApplicationController
  before_action :authenticate!

  def index
    @booking_id = params[:booking_id] || 3
    @location_ids = location_params[:locations].map(&:to_i)
    @doctors = Doctor.at_locations(@location_ids)
  end

  private

  def location_params
    p params
    params.permit(locations: []).with_defaults(locations: [])
  end
end
