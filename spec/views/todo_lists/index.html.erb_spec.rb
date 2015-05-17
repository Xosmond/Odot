require 'rails_helper'

RSpec.describe "todo_lists/index", type: :view do
  before(:each) do
    assign(:todo_lists, [
      TodoList.create!(
        :titulo => "Titulo",
        :descripcion => "MyTextcorriendo"
      ),
      TodoList.create!(
        :titulo => "Titulo",
        :descripcion => "MyTextcorriendo"
      )
    ])
  end

  it "renders a list of todo_lists" do
    render
    assert_select "div>strong", :text => "Titulo".to_s, :count => 2
    assert_select "strong+span", :text => "MyTextcorriendo".to_s, :count => 2
  end
end
