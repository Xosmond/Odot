require 'rails_helper'
require 'spec_helper'

describe "Actualizando tareas" do
	let!(:user) do
		sign_up email: "email@gone.com", password:"newpassnew"
	end

	let!(:todo_list){TodoList.create(user_id: User.all.pluck(:id).last, title:"Nueva lista", description: "Prueba de edicion.")}
	let!(:todo_item){TodoItem.create(todo_list_id: todo_list.id, content: "Correr en circulo")}

	def editar_item (opciones={})
		opciones[:content] ||= "Contenido Editado"
		todo_item = opciones[:todo_item]
		todo_list = opciones[:todo_list]
		visit todo_list_path(todo_list)
		find("#Edit").click
		expect(page).to have_content("Editar Tarea")
		fill_in "todo_item[content]", with: opciones[:content]
		click_button "Actualizar Todo item"
	end

	it "lo hace sin problemas" do
		editar_item todo_list: todo_list,todo_item: todo_item
		expect(page).to have_content("Tarea actualizada satisfactoriamente.")
	end

	it "muestra un error cuando no existe contenido" do
		editar_item todo_list: todo_list,todo_item: todo_item, content: ""
		expect(page).to_not have_content("Tarea actualizada satisfactoriamente.")
	end

	it "muestra un error cuando no el contenido tiene menos de dos letras" do
		editar_item todo_list: todo_list,todo_item: todo_item, content: "a"
		expect(page).to_not have_content("Tarea actualizada satisfactoriamente.")
	end
end
