require 'rails_helper'

RSpec.describe TodoListsController, type: :controller do
  let(:valid_attributes) {{"title" => "Nuevo Titulo", "description"=>"Mi nueva descripcion"}}
  let(:invalid_attributes) {{"title" => "N", "description"=>"Mi"}}
  let!(:user) { create(:user) }
  before do
    sign_in user
  end

  describe "GET #index" do
    it "Listar las listas del usuario." do
      todo_list = user.todo_lists.create! valid_attributes
      get :index
      expect(todo_list).to eq(todo_list)
      expect(assigns(:todo_lists).map(&:user)).to eq([user])
    end
  end

  describe "GET #show" do
    it "assigns the requested todo_list as @todo_list" do
      todo_list = user.todo_lists.create! valid_attributes
      get :show, params: { id: todo_list.to_param }
      expect(assigns(:todo_list)).to eq(todo_list)
    end
  end

  describe "GET #new" do
    it "assigns a new todo_list as @todo_list" do
      todo_list = user.todo_lists.new
      get :new
      expect(todo_list).to be_a_new(TodoList)
      expect(todo_list.user).to eq(user)
    end
  end

  describe "GET #edit" do
    it "assigns the requested todo_list as @todo_list" do
      todo_list = user.todo_lists.create! valid_attributes
      get :edit, params: { id: todo_list.to_param }
      expect(assigns(:todo_list)).to eq(todo_list)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new TodoList" do
        expect {
          post :create, params: { todo_list: valid_attributes }
        }.to change(TodoList, :count).by(1)
      end

      it "assigns a newly created todo_list as @todo_list" do
        post :create, params: { todo_list: valid_attributes }
        expect(assigns(:todo_list)).to be_a(TodoList)
        expect(assigns(:todo_list)).to be_persisted
      end

      it "redirects to the created todo_list" do
        post :create, params:  { todo_list: valid_attributes}
        expect(response).to redirect_to(TodoList.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved todo_list as @todo_list" do
        post :create, params: { todo_list: invalid_attributes }
        expect(assigns(:todo_list)).to be_a_new(TodoList)
      end

      it "re-renders the 'new' template" do
        post :create, params: { todo_list: invalid_attributes }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes){{"title" => "Titulo Actualizado", "description" => "Mi nueva descripcion Actualizado"}}

      it "updates the requested todo_list" do
        todo_list = user.todo_lists.create! valid_attributes
        put :update, params: { id: todo_list.to_param, todo_list: new_attributes}
        todo_list.reload
        expect(assigns(:todo_list).title).to eq("Titulo Actualizado")
        expect(assigns(:todo_list).description).to eq("Mi nueva descripcion Actualizado")
      end

      it "assigns the requested todo_list as @todo_list" do
        todo_list = user.todo_lists.create! valid_attributes
        put :update, params: { id: todo_list.to_param, todo_list: valid_attributes}
        expect(assigns(:todo_list)).to eq(todo_list)
      end

      it "redirects to the todo_list" do
        todo_list = user.todo_lists.create! valid_attributes
        put :update, params: { id: todo_list.to_param, todo_list: valid_attributes}
        expect(response).to redirect_to todo_list
      end
    end

    context "with invalid params" do
      it "assigns the todo_list as @todo_list" do
        todo_list = user.todo_lists.create! valid_attributes
        put :update, params: { id: todo_list.to_param, todo_list: invalid_attributes}
        expect(assigns(:todo_list)).to eq(todo_list)
      end

      it "re-renders the 'edit' template" do
        todo_list = user.todo_lists.create! valid_attributes
        put :update, params: { id: todo_list.to_param, todo_list: invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested todo_list" do
      todo_list = user.todo_lists.create! title: "Sample", description: "aaaasdad"
      expect {
        delete :destroy, params: { id: todo_list.to_param}
      }.to change(TodoList, :count).by(-1)
    end

    it "redirects to the todo_lists list" do
      todo_list = user.todo_lists.create! valid_attributes
      delete :destroy, params: { id: todo_list.to_param}
      expect(response).to redirect_to(todo_lists_url)
    end
  end

end
