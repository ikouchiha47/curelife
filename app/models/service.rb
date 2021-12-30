class Service < ApplicationRecord
	enum types: {
		ambulance: 1,
		labtest: 2,
		doctor: 3,
		help: 4
	}
		
	Ambulance = OpenStruct.new({
		id: Service.types[:ambulance],
		description: 'Book Ambulance',
		asset_url: "ambulance.jpeg"
	})

	Doctor = OpenStruct.new({
		id: Service.types[:doctor],
		description: "Book Appointment",
		asset_url: "doctor.jpeg"
	})

	LabTest = OpenStruct.new({
		id: Service.types[:labtest],
		description: "Book a test",
		asset_url: "labtest.jpeg"
	})

	Help = OpenStruct.new({
		id: Service.types[:help],
		description: "Send Help",
		asset_url: "medhelp.jpeg"
	})


	def self.all
		[Ambulance, Doctor, LabTest, Help]
	end

	def self.find_by_service_id(ids)
		Service.all.filter { |s| ids.include?(s.id)}
	end
end