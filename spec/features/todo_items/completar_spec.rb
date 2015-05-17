require 'rails_helper'
require 'spec_helper'

describe "Completando tareas : " do
let!(:usuario) do
	registro email: "email@gone.com", password:"newpassnew"
end
let!(:todo_list){TodoList.create(usuario_id:1,titulo:"Nueva lista",descripcion:"Prueba de edicion.")}
let!(:todo_item){TodoItem.create(todo_list_id:1,contenido:"Correr en circulo")}
	def completar_item (opciones={})
		todo_item = opciones[:todo_item]
		todo_list = opciones[:todo_list]
		visit todo_list_path(todo_list)
		within "#todo_item_#{todo_list.id}" do
			click_link "C"
		end
	end
	it "lo hace sin problemas" do
		expect(todo_item.completado_en).to be_nil
		completar_item todo_list: todo_list,todo_item: todo_item
		todo_item.reload
		expect(page).to have_content("Tarea Completada.")
		expect(todo_item.completado_en).to_not be_nil
		within "#todo_item_#{todo_list.id}" do
			expect(page).to have_content("Co")
		end
	end
end