require 'rails_helper'
require 'spec_helper'

describe "Viendo los items : " do
let!(:todo_list){TodoList.create(titulo:"Nueva lista",descripcion:"Prueba de items.")}
	it "No muestra ningun item cuando la lista esta vacia" do
		visit "/todo_lists"
		find_by_id('todo_list_'+todo_list.id.to_s).click
		expect(page).to have_content(todo_list.titulo)
	end
end