require 'rails_helper'
require 'spec_helper'

describe "Editando listas : " do
let!(:user) do
	sign_up email: "email@gone.com", password:"newpassnew"
end
let!(:todo_list){TodoList.create(user_id: User.all.pluck(:id).last, title:"Nueva lista", description: "Prueba de edicion.")}
	def editar_tarea (opciones={})
		opciones[:title] ||= "Nueva lista loca"
		opciones[:description] ||= "Correr en circulo"
		todo_list = opciones[:todo_list]
		click_link "Editar lista"
		fill_in "todo_list[title]", with: opciones[:title]
		fill_in "todo_list[description]", with: opciones[:description]
		click_button "Actualizar Todo list"

	end
	it "Lo hace perfectamente." do
		visit "/todo_lists/#{todo_list.id}"
		editar_tarea todo_list: todo_list, title:"New Titulo", description: "New Descripcion"
		todo_list.reload
		expect(page).to have_content("La lista ha sido actualizada satisfactoriamente.")
		expect(todo_list.title).to eq("New Titulo")
		expect(todo_list.description).to eq("New Descripcion")
	end
	it "Manda error cuando no tiene titulo." do
		visit "/todo_lists/#{todo_list.id}"
		editar_tarea todo_list: todo_list, title:"", description: "New Descripcion"
		todo_list.reload
		expect(page).to_not have_content("La lista ha sido actualizada satisfactoriamente.")
		expect(todo_list.title).to_not eq("New Titulo")
		expect(todo_list.description).to_not eq("New Descripcion")
	end
	it "Manda error cuando no tiene descripcion." do
		visit "/todo_lists/#{todo_list.id}"
		editar_tarea todo_list: todo_list, title:"New Titulo", description: ""
		todo_list.reload
		expect(page).to_not have_content("La lista ha sido actualizada satisfactoriamente.")
		expect(todo_list.title).to_not  eq("New Titulo")
		expect(todo_list.description).to_not eq("New Descripcion")
	end
	it "Manda error cuando el titulo no tiene al menos 3 letras." do
		visit "/todo_lists/#{todo_list.id}"
		editar_tarea todo_list: todo_list, title:"Ne", description: "New Descripcion"
		todo_list.reload
		expect(page).to_not have_content("La lista ha sido actualizada satisfactoriamente.")
		expect(todo_list.title).to_not eq("New Titulo")
		expect(todo_list.description).to_not eq("New Descripcion")
	end
	it "Manda error cuando la descripcion no tiene almenos 10 letras." do
		visit "/todo_lists/#{todo_list.id}"
		editar_tarea todo_list: todo_list, title:"New Titulo", description: "New"
		todo_list.reload
		expect(page).to_not have_content("La lista ha sido actualizada satisfactoriamente.")
		expect(todo_list.title).to_not eq("New Titulo")
		expect(todo_list.description).to_not eq("New Descripcion")
	end
end
