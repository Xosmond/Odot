class TodoList < ActiveRecord::Base
	validates :titulo, presence:true, length: {minimum: 3}
	validates :descripcion, presence:true, length: {minimum: 7}
end
