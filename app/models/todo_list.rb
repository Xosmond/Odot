class TodoList < ActiveRecord::Base
	belongs_to :usuario
	has_many :todo_items
	validates :titulo, presence:true, length: {minimum: 3}
	validates :descripcion, presence:true, length: {minimum: 7}
end
