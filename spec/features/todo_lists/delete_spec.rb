require 'rails_helper'
require 'spec_helper'

describe "Editando listas" do
let!(:todo_list){TodoList.create(titulo:"Nueva entrada",descripcion:"Prueba de edicion.")}
	def eliminar_tarea
		within "#todo_list_#{todo_list.id}" do
			click_link "Eliminar"
		end
	end
	it "Elimina perfectamente la entrada" do
		visit "/todo_lists"
		eliminar_tarea 
		expect(page).to have_content("La tarea ha sido eliminada satisfactoriamente.")
		expect(TodoList.count).to eq(0)
	end
end