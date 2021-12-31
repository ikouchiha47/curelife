module ApplicationHelper
	def javascript_exists?(script)
  		script = "#{Rails.root}/app/javascript/#{script}.js"
  		File.exists?(script) || File.exists?("#{script}.coffee") 
	end
end
