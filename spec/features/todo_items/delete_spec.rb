require 'rails_helper'
require 'spec_helper'

describe "Eliminando tareas" do
let!(:usuario) do
	registro email: "email@gone.com", password:"newpassnew"
end
let!(:todo_list){TodoList.create(usuario_id:1,titulo:"Nueva lista",descripcion:"Prueba de edicion.")}
let!(:todo_item){TodoItem.create(todo_list_id:1,contenido:"Correr en circulo")}
	def eliminar_item (opciones={})
		todo_item = opciones[:todo_item]
		todo_list = opciones[:todo_list]
		visit todo_list_path(todo_list)
		within "#todo_item_#{todo_list.id}" do
			find("#Delete").click
		end
	end
	it "lo hace sin problemas" do
		eliminar_item todo_list: todo_list,todo_item: todo_item
		within "table tbody" do
			expect(page).to_not have_content("Correr en circulo")
		end
		expect(page).to have_content("La tarea ha sido eliminada satisfactoriamente.")
		expect(TodoItem.count).to eq(0)
	end
end