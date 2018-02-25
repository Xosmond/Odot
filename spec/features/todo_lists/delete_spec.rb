require 'rails_helper'
require 'spec_helper'

describe "Eliminando listas : " do
let!(:user) do
	sign_up email: "email@gone.com", password:"newpassnew"
end
let!(:todo_list){TodoList.create(user_id: User.all.pluck(:id).last, title:"Nueva lista", description: "Prueba de edicion.")}
	def eliminar_lista
		click_link "Eliminar lista"
	end
	it "Lo hace perfectamente." do
		visit "/todo_lists/#{todo_list.id}"
		eliminar_lista
		expect(page).to have_content("La lista ha sido eliminada satisfactoriamente.")
		expect(TodoList.count).to eq(0)
	end
end
