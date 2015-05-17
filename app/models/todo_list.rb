class TodoList < ActiveRecord::Base
	belongs_to :usuario
	has_many :todo_items
	validates :titulo, presence:true, length: {minimum: 3}
	validates :descripcion, presence:true, length: {minimum: 7}
	def has_completed_items?
    	todo_items.complete.size > 0
	end

	def has_incomplete_items?
	  	todo_items.incomplete.size > 0
	end 
end
