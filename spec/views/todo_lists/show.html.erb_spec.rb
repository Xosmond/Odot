require 'rails_helper'

RSpec.describe "todo_lists/show", type: :view do
  before(:each) do
    @todo_list = assign(:todo_list, TodoList.create!(
      :titulo => "Titulo",
      :descipcion => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Titulo/)
    expect(rendered).to match(/MyText/)
  end
end
