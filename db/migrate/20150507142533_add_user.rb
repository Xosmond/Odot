class AddUser < ActiveRecord::Migration
  def change
  	add_column :todo_lists, :usuario_id, :integer
  	add_index :todo_lists, :usuario_id
  end
end
