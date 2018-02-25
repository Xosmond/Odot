require 'rails_helper'

RSpec.describe TodoItemsController, type: :controller do
before do
    user = User.new(email:"new@email.com",encrypted_password:"mynewpass")
    sign_in user
  end
end
