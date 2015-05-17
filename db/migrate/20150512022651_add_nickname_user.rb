class AddNicknameUser < ActiveRecord::Migration
  def change
  	  	add_column :usuarios, :nickname, :string
  end
end
