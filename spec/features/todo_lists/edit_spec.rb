require 'rails_helper'
require 'spec_helper'

describe "Editando listas" do
let!(:todo_list){TodoList.create(titulo:"Nueva entrada",descripcion:"Prueba de edicion.")}
	def editar_tarea (opciones={})
		opciones[:titulo] ||= "Nueva tarea loca"
		opciones[:descripcion] ||= "Correr en circulo"

		todo_list = opciones[:todo_list]

		visit "/todo_lists"

		within "todo_list_#{todo_list.id}" do
			click_link "Editar"
		end

		fill_in "Titulo", with: opciones[:titulo]
		fill_in "Descripcion", with: opciones[:descripcion]
		click_button "Actualizar Todo list"

	end
	it "Edita perfectamente la entrada" do
		visit "/todo_lists"

		editar_tarea todo_list: todo_list,titulo:"New Titulo",descripcion: "New Descripcion"
		entrada.reload

		expect(page).to have_content("La tarea ha sido creada satisfactoriamente.")
		expect(entrada.titulo).to eq("New titulo")
		expect(entrada.descripcion).to eq("New descripcion")
	end
end