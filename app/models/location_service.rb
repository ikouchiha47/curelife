class LocationService < ApplicationRecord
	def available_services
		service_ids = self.services.split(",").map(&:to_i)

		Service.find_by_service_id(service_ids)
	end
end
