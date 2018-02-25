require 'rails_helper'
require 'spec_helper'

describe "Creando listas : " do
let!(:user) do
	sign_up email: "email@gone.com", password:"newpassnew"
end
	def create_task (opciones={})
		opciones[:title] ||= "Nueva lista loca"
		opciones[:description] ||= "Correr en circulo"
		visit "/todo_lists"
		expect(page).to have_content ("Mis Listas")
		find("#Add").click
		expect(page).to have_content("Nueva Lista")
		fill_in "todo_list[title]", with: opciones[:title]
		fill_in "todo_list[description]", with: opciones[:description]
		click_button "Crear Todo list"
	end

	it "Lo hace Perfectamente." do
		create_task
		expect(page).to have_content("La lista ha sido creada satisfactoriamente.")
	end
	it "Manda error si no se pone el titulo de la lista." do
		expect(TodoList.all.count).to eq(0)
		create_task title: ""
		expect(TodoList.all.count).to eq(0)
		expect(page).to have_content("error")
		visit "/todo_lists"
		expect(page).to_not have_content("Correr en circulo")
	end
	it "Manda error si el titulo de la lista tiene menos de 3 letras." do
		expect(TodoList.all.count).to eq(0)
		create_task title: "Ha"
		expect(TodoList.all.count).to eq(0)
		expect(page).to have_content("error")
		visit "/todo_lists"
		expect(page).to_not have_content("Correr en circulo")
	end
	it "Manda error si no se pone la descripcion de la lista." do
		expect(TodoList.all.count).to eq(0)
		create_task description: ""
		expect(TodoList.all.count).to eq(0)
		expect(page).to have_content("error")
		visit "/todo_lists"
		expect(page).to_not have_content("Nueva lista loca")
	end
	it "Manda error si la descripcion de la lista es menor de 10 letras." do
		expect(TodoList.all.count).to eq(0)
		create_task description: "hogar"
		expect(TodoList.all.count).to eq(0)
		expect(page).to have_content("error")
		visit "/todo_lists"
		expect(page).to_not have_content("Nueva lista loca")
	end
end
