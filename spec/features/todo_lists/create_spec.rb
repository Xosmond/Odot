require 'rails_helper'
require 'spec_helper'

describe "creando listas" do
	it "redirecciona a la pagina de feed cuando esta correcto" do
		visit "/todo_lists"
		click_link "Nueva tarea"
		expect(page).to have_content("Nueva Tarea")
		fill_in "Titulo", with: "Nueva tarea"
		fill_in "Descripcion", with: "Hare esto primero"
		click_button "Crear nueva tarea"
		expect(page).to have_content("Su nueva Tarea ha sido creada")
	end
	it "Manda error si no se pone el titulo de la tarea" do
		expect(TodoList.all.count).to eq(0)

		visit "/todo_lists"
		click_link "Nueva tarea"
		expect(page).to have_content("Nueva Tarea")
		fill_in "Descripcion", with: "Hare esto primero"
		click_button "Crear nueva tarea"

		expect(TodoList.all.count).to eq(0)
		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).to_not have_content("Hare esto primero")
	end
end