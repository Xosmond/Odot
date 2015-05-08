class TodoItemsController < ApplicationController
  before_action :authenticate_usuario!
  before_action :find_todo_list, only: [:new,:create, :edit, :update,:destroy,:complete]
  def index
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
      format.html { redirect_to todo_list_url, notice: 'La tarea ha sido eliminada satisfactoriamente.' }
      format.json { head :no_content }
      else
      end
    end
  end
  def complete
    @todo_item = @todo_list.todo_items.find(params[:todo_item_id])
    respond_to do |format|
      if @todo_item.update_attribute(:completado_en, Time.now)
        format.html { redirect_to todo_list_path(@todo_list.id), notice: 'Tarea Completada.' }
        format.json { render :show, status: :ok, location: @todo_item }
      else
        format.html { render :new }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
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
    params.require(:todo_item).permit(:contenido)
  end
end
