class TodoItemsController < ApplicationController
  def index
  	 @todo_list = TodoList.find(params[:todo_list_id])
  end
  def new
  	@todo_list = TodoList.find(params[:todo_list_id])
  	@todo_item = @todo_list.todo_items.new
  end
  def create
  	@todo_list = TodoList.find(params[:todo_list_id])
  	@todo_item = @todo_list.todo_items.new(todo_list_params)
  	if @todo_item.save
  		flash[:success] = "Tarea agregada satisfactoriamente."
  		redirect_to todo_list_path(@todo_list.id)
  	else
  		flash[:error] = "No se pudo agregar la tarea."
  		render action: :new 
  	end
  end
  def todo_list_params
    params.require(:todo_item).permit(:contenido)
  end
end
