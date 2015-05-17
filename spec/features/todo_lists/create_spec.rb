require 'rails_helper'
require 'spec_helper'

describe "Creando listas : " do
let!(:usuario) do
	registro email: "email@gone.com", password:"newpassnew"
end
	def crear_tarea (opciones={})
		opciones[:titulo] ||= "Nueva lista loca"
		opciones[:descripcion] ||= "Correr en circulo"
		visit "/todo_lists"
		expect(page).to have_content ("Mis Listas")
		find("#Add").click
		expect(page).to have_content("Nueva Lista")
		fill_in "Titulo", with: opciones[:titulo]
		fill_in "Descripcion", with: opciones[:descripcion]
		click_button "Crear Todo list"
	end
	it "Lo hace Perfectamente." do
		crear_tarea
		expect(page).to have_content("La lista ha sido creada satisfactoriamente.")
	end
	it "Manda error si no se pone el titulo de la lista." do
		expect(TodoList.all.count).to eq(0)
		crear_tarea titulo:""
		expect(TodoList.all.count).to eq(0)
		expect(page).to have_content("error")
		visit "/todo_lists"
		expect(page).to_not have_content("Correr en circulo")
	end
	it "Manda error si el titulo de la lista tiene menos de 3 letras." do
		expect(TodoList.all.count).to eq(0)
		crear_tarea titulo:"Ha"
		expect(TodoList.all.count).to eq(0)
		expect(page).to have_content("error")
		visit "/todo_lists"
		expect(page).to_not have_content("Correr en circulo")
	end
	it "Manda error si no se pone la descripcion de la lista." do
		expect(TodoList.all.count).to eq(0)
		crear_tarea descripcion:""
		expect(TodoList.all.count).to eq(0)
		expect(page).to have_content("error")
		visit "/todo_lists"
		expect(page).to_not have_content("Nueva lista loca")
	end
	it "Manda error si la descripcion de la lista es menor de 10 letras." do
		expect(TodoList.all.count).to eq(0)
		crear_tarea descripcion:"hogar"
		expect(TodoList.all.count).to eq(0)
		expect(page).to have_content("error")
		visit "/todo_lists"
		expect(page).to_not have_content("Nueva lista loca")
	end
end