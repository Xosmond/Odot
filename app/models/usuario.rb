class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :todo_lists

  before_save :downcase_email

  def nombre_completo
    nombres + " " + apellidos
  end
  def gravatar_url 
    "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase.strip)}"
  end
  def downcase_email
    self.email = email.downcase
  end

  def generate_password_reset_token!
    update_attribute(:password_reset_token, SecureRandom.urlsafe_base64(48))
  end
  def create_default_lists
    tutorial = todo_lists.find_or_create_by(title: "ODOT Tutorial")
    tutorial.todo_items.find_or_create_by(content: "Add a todo list or item by clicking the \"+\" button at the top.")
    tutorial.todo_items.find_or_create_by(content: "The numbers next to a list indicate how many items it has.")
    tutorial.todo_items.find_or_create_by(content: "Clicking or tapping the list title brings up list items.")
    tutorial.todo_items.find_or_create_by(content: "Clicking or tapping the list title again gives you more options.")
    tutorial.todo_items.find_or_create_by(content: "Clicking or tapping a checkmark next to an item marks it complete.")
    tutorial.todo_items.find_or_create_by(content: "Clicking or tapping it again marks it incomplete.")
    tutorial.todo_items.find_or_create_by(content: "Clicking or tapping the item lets you edit or delete it.")
  end
end
