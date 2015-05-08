require 'rails_helper'

RSpec.describe Usuario, type: :model do
	it {should have_many(:todo_lists)}
end
