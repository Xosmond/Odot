require 'rails_helper'

RSpec.describe "todo_lists/edit", type: :view do
  before(:each) do
    @todo_list = assign(:todo_list, TodoList.create!(
      :titulo => "MyStringnewpo",
      :descripcion => "MyTextcountingnow"
    ))
  end

  it "renders the edit todo_list form" do
    render

    assert_select "form[action=?][method=?]", todo_list_path(@todo_list), "post" do

      assert_select "input#todo_list_titulo[name=?]", "todo_list[titulo]"

      assert_select "textarea#todo_list_descripcion[name=?]", "todo_list[descripcion]"
    end
  end
end
