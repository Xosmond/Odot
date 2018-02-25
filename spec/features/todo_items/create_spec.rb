require 'rails_helper'
require 'spec_helper'

describe "Creando tareas" do
	let!(:user) do
		sign_up email: "email@gone.com", password:"newpassnew"
	end
	let!(:todo_list){TodoList.create(user_id:User.all.pluck(:id).last, title:"Nueva lista", description: "Prueba de edicion.")}

	def crear_item (options={})
		options[:content] ||= "Nueva contenido loco"
		visit "/todo_lists/#{todo_list.id}"
		find("#Add").click
		expect(page).to have_content("Nueva Tarea")
		fill_in "todo_item[content]", with: options[:content]
		click_button "Crear Todo item"
	end

	it "Crea perfectamente la tarea" do
		crear_item
		expect(page).to have_content("Tarea agregada satisfactoriamente.")
		expect(page).to have_content("Nueva contenido loco")
	end

	it "muestra un error cuando no existe contenido" do
		crear_item content:""
		expect(page).to_not have_content("Tarea agregada satisfactoriamente.")
	end

	it "muestra un error cuando no el contenido tiene menos de dos letras" do
		crear_item content:"a"
		expect(page).to_not have_content("Tarea agregada satisfactoriamente.")
	end
end
