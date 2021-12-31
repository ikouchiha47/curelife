class Patients::PatientsController < ApplicationController
	def login
	end

	def signup
	end

	def authenticate
		patient = Patient.find_by(phone: patient_params.phone, country_code: patient_params.country_code)

		if patient.try(:authentic?, patient_params[:password])
			dk = Doorkeeper::AccessToken.create!(application_id: nil, expires_in: 2.hours, resource_owner_id: patient.id, scopes: 'public')
			session[:access_token] = dk.token
			redirect_to user_bookings_path(patient) and return
		end
		
		flash[:error] = "Invalid login"
		redirect_to patients_login_path
	end

	def create
		patient = Patient.new(
			name: patient_params.name,
			phone: patient_params.phone,
			country_code: patient_params.country_code,
			birthdate: Date.strptime(patient_params.birthdate, "%Y-%m-%d"),
			password: patient_params.password,
			password_confirmation: patient_params.password
		)

		if patient.save
			redirect_to patients_show_path(patient) and return
		end

		flash[:errors] = patient.errors.full_messages
		redirect_to patients_signup_path
	end

	private

		def patient_params
			OpenStruct.new(params.permit(:country_code, :phone, :password, :name, :birthdate))
		end
end