require 'rails_helper'
require 'spec_helper'

describe "Editando listas : " do
let!(:todo_list){TodoList.create(titulo:"Nueva lista",descripcion:"Prueba de edicion.")}
	def editar_tarea (opciones={})
		opciones[:titulo] ||= "Nueva lista loca"
		opciones[:descripcion] ||= "Correr en circulo"
		todo_list = opciones[:todo_list]
		click_link "Editar lista"
		fill_in "Titulo", with: opciones[:titulo]
		fill_in "Descripcion", with: opciones[:descripcion]
		click_button "Actualizar Todo list"

	end
	it "Lo hace perfectamente." do
		visit "/todo_lists/#{todo_list.id}"
		editar_tarea todo_list: todo_list,titulo:"New Titulo",descripcion: "New Descripcion"
		todo_list.reload
		expect(page).to have_content("La lista ha sido actualizada satisfactoriamente.")
		expect(todo_list.titulo).to eq("New Titulo")
		expect(todo_list.descripcion).to eq("New Descripcion")
	end
	it "Manda error cuando no tiene titulo." do
		visit "/todo_lists/#{todo_list.id}"
		editar_tarea todo_list: todo_list,titulo:"",descripcion: "New Descripcion"
		todo_list.reload
		expect(page).to_not have_content("La lista ha sido actualizada satisfactoriamente.")
		expect(todo_list.titulo).to_not eq("New Titulo")
		expect(todo_list.descripcion).to_not eq("New Descripcion")
	end
	it "Manda error cuando no tiene descripcion." do
		visit "/todo_lists/#{todo_list.id}"
		editar_tarea todo_list: todo_list,titulo:"New Titulo",descripcion: ""
		todo_list.reload
		expect(page).to_not have_content("La lista ha sido actualizada satisfactoriamente.")
		expect(todo_list.titulo).to_not  eq("New Titulo")
		expect(todo_list.descripcion).to_not eq("New Descripcion")
	end
	it "Manda error cuando el titulo no tiene al menos 3 letras." do
		visit "/todo_lists/#{todo_list.id}"
		editar_tarea todo_list: todo_list,titulo:"Ne",descripcion: "New Descripcion"
		todo_list.reload
		expect(page).to_not have_content("La lista ha sido actualizada satisfactoriamente.")
		expect(todo_list.titulo).to_not eq("New Titulo")
		expect(todo_list.descripcion).to_not eq("New Descripcion")
	end
	it "Manda error cuando la descripcion no tiene almenos 10 letras." do
		visit "/todo_lists/#{todo_list.id}"
		editar_tarea todo_list: todo_list,titulo:"New Titulo",descripcion: "New"
		todo_list.reload
		expect(page).to_not have_content("La lista ha sido actualizada satisfactoriamente.")
		expect(todo_list.titulo).to_not eq("New Titulo")
		expect(todo_list.descripcion).to_not eq("New Descripcion")
	end
end