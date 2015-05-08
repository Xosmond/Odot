class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :todo_lists
  def gravatar_url 
    "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase.strip)}"
  end
end
