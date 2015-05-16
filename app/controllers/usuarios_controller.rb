class UsuariosController < ApplicationController
  def mostrar
  	@usuario = Usuario.find(params[:id])
  	if @usuario
  		render action: :mostrar
  	else
  		render file: 'public/404', status: 404, formats: [:html]
  	end
  end
end
