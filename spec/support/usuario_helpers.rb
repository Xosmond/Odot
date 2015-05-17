module UsuarioHelpers
	def registro (opciones={})
		visit "/"
		click_link "Registrarse"
		within "form" do
			fill_in :usuario_email, with: opciones[:email]
			fill_in :usuario_password, with: opciones[:password] 
			fill_in :usuario_password_confirmation, with: opciones[:password]
			click_button "Registrarse"
		end
	end

	def iniciar_sesion (opciones={})
		visit "/"
		expect(page).to have_content("Ingresar")
		fill_in :usuario_email, with: opciones[:email]
		fill_in :usuario_password, with: opciones[:password] 
		click_button "Ingresar"
	end
end