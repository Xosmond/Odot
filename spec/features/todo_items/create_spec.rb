require 'rails_helper'
require 'spec_helper'

describe "Creando tareas" do
let!(:usuario) do
	registro email: "email@gone.com", password:"newpassnew"
end
let!(:todo_list){TodoList.create(usuario_id:1,titulo:"Nueva lista",descripcion:"Prueba de edicion.")}
	def crear_item (opciones={})
		opciones[:contenido] ||= "Nueva contenido loco"
		visit "/todo_lists/#{todo_list.id}"
		find("#Add").click
		expect(page).to have_content("Nueva Tarea")
		fill_in "Contenido", with: opciones[:contenido]
		click_button "Crear Todo item"
	end
	it "Crea perfectamente la tarea" do
		crear_item
		expect(page).to have_content("Tarea agregada satisfactoriamente.")
		within ("#todo_item_#{todo_list.id}") do
			expect(page).to have_content("Nueva contenido loco")
		end
	end
	it "muestra un error cuando no existe contenido" do
		crear_item contenido:""
		expect(page).to_not have_content("Tarea agregada satisfactoriamente.")
		
	end
	it "muestra un error cuando no el contenido tiene menos de dos letras" do
		crear_item contenido:"a"
		expect(page).to_not have_content("Tarea agregada satisfactoriamente.")
	end
end