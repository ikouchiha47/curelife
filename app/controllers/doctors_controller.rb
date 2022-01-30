class DoctorsController < ApplicationController
  before_action :authenticate!

  def index
    @location_ids =params[:locations].map(&:to_i)
    @doctors = Doctor.at_locations(@location_ids)
  end

  private

    def location_params
      params.permit(:locations).with_defaults(locations: [])
    end
end
