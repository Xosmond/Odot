require 'rails_helper'

RSpec.describe "todo_lists/new", type: :view do
  before(:each) do
    assign(:todo_list, TodoList.new(
      :titulo => "MyStringnewpo",
      :descripcion => "MyTextcountingnow"
    ))
  end

  it "renders new todo_list form" do
    render

    assert_select "form[action=?][method=?]", todo_lists_path, "post" do

      assert_select "input#todo_list_titulo[name=?]", "todo_list[titulo]"

      assert_select "textarea#todo_list_descripcion[name=?]", "todo_list[descripcion]"
    end
  end
end
