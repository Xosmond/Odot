require 'rails_helper'
require 'spec_helper'

describe "Viendo Tareas : " do
	let!(:user) do
		sign_up email: "email@gone.com", password:"newpassnew"
	end

	let!(:todo_list){TodoList.create(user_id: User.all.pluck(:id).last, title:"Nueva lista", description: "Prueba de items.")}

	it "muestra ningun el titulo de la lista." do
		visit "/todo_lists/#{todo_list.id}"
		expect(page).to have_content(todo_list.title)
	end

	it "muestra ningun item cuando la lista esta vacia." do
		visit "/todo_lists/#{todo_list.id}"
		expect(page).to have_content(todo_list.title)
		expect(page.all('table tbody tr').count == 0)
	end

	it "muestra todos los items de la lista." do
		todo_list.todo_items.create(content: "Comprar Leche")
		todo_list.todo_items.create(content: "Comprar Carbon")

		visit "/todo_lists/#{todo_list.id}"

		expect(page.all('table tbody tr').count == 2)

		within ("table tbody") do
			expect(page).to have_content("Comprar Leche")
			expect(page).to have_content("Comprar Carbon")
		end
	end
end
