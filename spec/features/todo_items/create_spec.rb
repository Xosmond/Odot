require 'rails_helper'
require 'spec_helper'

describe "Creando tareas" do
let!(:todo_list){TodoList.create(titulo:"Nueva lista",descripcion:"Prueba de edicion.")}
	def crear_item (opciones={})
		opciones[:contenido] ||= "Nueva contenido loco"
		visit "/todo_lists/#{todo_list.id}"
		click_link "Nueva Tarea"
		expect(page).to have_content("Nueva Tarea")
		fill_in "Contenido", with: opciones[:contenido]
		click_button "Crear Todo item"
		expect(page).to have_content("Tarea agregada satisfactoriamente.")
		within ("table tbody") do
			expect(page).to have_content("Nueva contenido loco")
		end
	end
	it "Crea perfectamente la tarea" do
		crear_item
	end
end