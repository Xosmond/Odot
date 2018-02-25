class TodoItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_todo_list, only: [:index,:show,:new,:create, :edit, :update,:destroy,:complete]
  before_action :verify_ownership
  def index
  end
  def show
    respond_to do |format|
      format.html { redirect_to @todo_list }
      format.json { head :no_content }
    end
  end

  def new
  	@todo_item = @todo_list.todo_items.new
  end

  def create
  	@todo_item = @todo_list.todo_items.new(todo_item_params)
    respond_to do |format|
      if @todo_item.save
        format.html { redirect_to todo_list_path(@todo_list.id), notice: 'Tarea agregada satisfactoriamente.' }
        format.json { render :show, status: :created, location: @todo_item }
      else
        format.html { render :new }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @todo_item = @todo_list.todo_items.find(params[:id])
  end

  def update
    @todo_item = @todo_list.todo_items.find(params[:id])
    respond_to do |format|
      if @todo_item.update_attributes(todo_item_params)
        format.html { redirect_to todo_list_path(@todo_list.id), notice: 'Tarea actualizada satisfactoriamente.' }
        format.json { render :show, status: :ok, location: @todo_item }
      else
        format.html { render :new }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @todo_item = @todo_list.todo_items.find(params[:id])
    respond_to do |format|
      if @todo_item.destroy
      format.html { redirect_to todo_list_path(@todo_list.id), notice: 'La tarea ha sido eliminada satisfactoriamente.' }
      format.json { head :no_content }
      else
      end
    end
  end

  def complete
    @todo_item = @todo_list.todo_items.find(params[:todo_item_id])
    respond_to do |format|
      if @todo_item.update_attribute(:completed_at, Time.now)
        format.html { redirect_to todo_list_path(@todo_list.id), notice: 'Tarea Completada.' }
        format.json { render :show, status: :ok, location: @todo_item }
      else
        format.html { render :new }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def verify_ownership
    if @todo_list.user_id != current_user.id
      respond_to do |format|
      format.html { redirect_to todo_lists_url, notice: 'No puede acceder a listas que no le pertenecen' }
      format.json { head :no_content }
      end
    end
  end

  def find_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def url_options
      {todo_list_id: params[:todo_list_id]}.merge(super)
  end

  def todo_item_params
    params.require(:todo_item).permit(:content)
  end
end
