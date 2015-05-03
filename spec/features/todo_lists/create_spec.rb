require 'rails_helper'
require 'spec_helper'

describe "creando listas" do
	def crear_tarea (opciones={})
		opciones[:titulo] ||= "Nueva tarea loca"
		opciones[:descripcion] ||= "Correr en circulo"
		visit "/todo_lists"
		click_link "Nueva tarea"
		expect(page).to have_content("Nueva Tarea")
		fill_in "Titulo", with: opciones[:titulo]
		fill_in "Descripcion", with: opciones[:descripcion]
		click_button "Crear nueva tarea"
	end
	it "redirecciona a la pagina de feed cuando esta correcto" do
		crear_tarea
		expect(page).to have_content("Su nueva Tarea ha sido creada")
	end
	it "Manda error si no se pone el titulo de la tarea" do
		expect(TodoList.all.count).to eq(0)
		crear_tarea titulo:""
		expect(TodoList.all.count).to eq(0)
		expect(page).to have_content("error")
		visit "/todo_lists"
		expect(page).to_not have_content("Correr en circulo")
	end
	it "Manda error si el titulo de la tarea tiene menos de 3 letras" do
		expect(TodoList.all.count).to eq(0)
		crear_tarea titulo:"Ha"
		expect(TodoList.all.count).to eq(0)
		expect(page).to have_content("error")
		visit "/todo_lists"
		expect(page).to_not have_content("Correr en circulo")
	end
	it "Manda error si no se pone la descripcion de la tarea" do
		expect(TodoList.all.count).to eq(0)
		crear_tarea descripcion:""
		expect(TodoList.all.count).to eq(0)
		expect(page).to have_content("error")
		visit "/todo_lists"
		expect(page).to_not have_content("Nueva tarea loca")
	end
	it "Manda error si la descripcion de la tarea es menor de 10 letras" do
		expect(TodoList.all.count).to eq(0)
		crear_tarea descripcion:"hogar"
		expect(TodoList.all.count).to eq(0)
		expect(page).to have_content("error")
		visit "/todo_lists"
		expect(page).to_not have_content("Nueva tarea loca")
	end
end