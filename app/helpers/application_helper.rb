module ApplicationHelper
	def flash_class (tipo)
	 	case tipo
	 	when 'alert'
	 		"alert-danger"
	 	when 'notice'
	 		"alert-success"
	 	end
	 end
end
