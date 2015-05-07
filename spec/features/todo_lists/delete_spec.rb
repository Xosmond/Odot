require 'rails_helper'
require 'spec_helper'

describe "Eliminando listas : " do
let!(:todo_list){TodoList.create(titulo:"Nueva lista",descripcion:"Prueba de edicion.")}
	def eliminar_tarea
		click_link "Eliminar lista"
	end
	it "Lo hace perfectamente." do
		visit "/todo_lists/#{todo_list.id}"
		eliminar_tarea 
		expect(page).to have_content("La lista ha sido eliminada satisfactoriamente.")
		expect(TodoList.count).to eq(0)
	end
end