class HomepageController < ApplicationController
  layout 'homepage'

  def index
    redirect_to user_bookings_path(current_user) and return if doorkeeper_token.present?

    @locations = Location::DEFAULT_ZIP_CODES
  end


  def services
    @location = Location.find_by(zip_code: zip_code)

    unless @location.present?
      flash[:error] = 'No services available or you need to register'
      render 'services' and return
    end

    @doctors = Doctor.at_locations(@location.id).take(5)
  end

  private
 
  def zip_code
    params[:location_id]
  end
end
