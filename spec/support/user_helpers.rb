module UserHelpers
	def sign_up (opciones={})
		visit "/"
		click_link "Registrarse"
		within "form" do
			fill_in :user_email, with: opciones[:email]
			fill_in :user_password, with: opciones[:password]
			fill_in :user_password_confirmation, with: opciones[:password]
			click_button "Registrarse"
		end
	end

	def sign_in_direct (opciones={})
		visit "/"
		expect(page).to have_content("Ingresar")
		fill_in :user_email, with: opciones[:email]
		fill_in :user_password, with: opciones[:password]
		click_button "Ingresar"
	end
end
