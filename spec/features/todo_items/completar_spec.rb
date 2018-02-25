require 'rails_helper'
require 'spec_helper'

describe "Completando tareas : " do
	let!(:user) do
		sign_up email: "email@gone.com", password:"newpassnew"
	end

	before :each do
		@list = TodoList.create!(user_id: User.all.pluck(:id).last, title:"Nueva lista", description: "Prueba de edicion.")
		@item = TodoItem.create!(todo_list_id: @list.id, content:"Correr en circulo")
	end

	it "lo hace sin problemas" do
		expect(@item.completed_at).to be_nil
		completar_item todo_list: @list,todo_item: @item
		@item.reload
		expect(page).to have_content("Tarea Completada.")
		expect(@item.completed_at).to_not be_nil
		expect(page).to have_content("Co")
	end

	def completar_item (opciones={})
		todo_item = opciones[:todo_item]
		todo_list = opciones[:todo_list]
		visit todo_list_path(todo_list)
		click_link "C"
	end
end
