require 'rails_helper'

RSpec.describe TodoItemsController, type: :controller do
before do
    usuario = Usuario.new(email:"new@email.com",encrypted_password:"mynewpass")
    sign_in usuario
  end
end
