class PagesController < ApplicationController
  def home
  	if usuario_signed_in?
  		redirect_to todo_lists_path
  	else
  		render layout: 'home' 
  	end
  end
end
