class DoctorsController < ApplicationController
  before_action :authenticate

  def index
    Doctor.find_by_locations(params[:locations])
  end
end
