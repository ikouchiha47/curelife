module FlashHelper
	def flash_class(level)
		case level
      		when 'notice' then 'bg-yellow-400'
      		when 'success' then 'bg-lime-500'
      		when 'error' then 'bg-red-500'
      		when 'alert' then 'bg-cyan-400'
    	end
	end
end