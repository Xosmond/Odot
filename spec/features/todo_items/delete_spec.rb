require 'rails_helper'
require 'spec_helper'

describe "Eliminando tareas" do
	let!(:user) do
		sign_up email: "email@gone.com", password:"newpassnew"
	end
	let!(:todo_list){TodoList.create!(user_id: User.all.pluck(:id).last, title:"Nueva lista", description: "Prueba de edicion.")}
	let!(:todo_item){TodoItem.create!(todo_list_id: todo_list.id, content: "Correr en circulo")}

	def eliminar_item (opciones={})
		todo_item = opciones[:todo_item]
		todo_list = opciones[:todo_list]
		visit todo_list_path(todo_list)
		find("#Delete").click
	end

	it "lo hace sin problemas" do
		eliminar_item todo_list: todo_list,todo_item: todo_item
		within "table tbody" do
			expect(page).to_not have_content("Correr en circulo")
		end
		expect(page).to have_content("La tarea ha sido eliminada satisfactoriamente.")
		expect(TodoItem.count).to eq(0)
	end
end
