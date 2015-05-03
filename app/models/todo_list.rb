class TodoList < ActiveRecord::Base
	validates :titulo, presence:true
end
