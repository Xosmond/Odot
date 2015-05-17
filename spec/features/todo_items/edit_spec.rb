require 'rails_helper'
require 'spec_helper'

describe "Actualizando tareas" do
let!(:usuario) do
	registro email: "email@gone.com", password:"newpassnew"
end
let!(:todo_list){TodoList.create(usuario_id:1,titulo:"Nueva lista",descripcion:"Prueba de edicion.")}
let!(:todo_item){TodoItem.create(todo_list_id:1,contenido:"Correr en circulo")}
	def editar_item (opciones={})
		opciones[:contenido] ||= "Contenido Editado"
		todo_item = opciones[:todo_item]
		todo_list = opciones[:todo_list]
		visit todo_list_path(todo_list)
		within "#todo_item_#{todo_list.id}" do
			find("#Edit").click
		end
		expect(page).to have_content("Editar Tarea")
		fill_in "Contenido", with: opciones[:contenido]
		click_button "Actualizar Todo item"
	end
	it "lo hace sin problemas" do
		editar_item todo_list: todo_list,todo_item: todo_item
		expect(page).to have_content("Tarea actualizada satisfactoriamente.")
	end
	it "muestra un error cuando no existe contenido" do
		editar_item todo_list: todo_list,todo_item: todo_item,contenido:""
		expect(page).to_not have_content("Tarea actualizada satisfactoriamente.")
		
	end
	it "muestra un error cuando no el contenido tiene menos de dos letras" do
		editar_item todo_list: todo_list,todo_item: todo_item,contenido:"a"
		expect(page).to_not have_content("Tarea actualizada satisfactoriamente.")
	end
end