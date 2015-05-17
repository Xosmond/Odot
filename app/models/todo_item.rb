class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
  validates :contenido, presence:true, length: {minimum: 2}
end
