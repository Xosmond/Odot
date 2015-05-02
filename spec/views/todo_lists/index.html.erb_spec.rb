require 'rails_helper'

RSpec.describe "todo_lists/index", type: :view do
  before(:each) do
    assign(:todo_lists, [
      TodoList.create!(
        :titulo => "Titulo",
        :descripcion => "MyText"
      ),
      TodoList.create!(
        :titulo => "Titulo",
        :descripcion => "MyText"
      )
    ])
  end

  it "renders a list of todo_lists" do
    render
    assert_select "tr>td", :text => "Titulo".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
