class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
      t.string :titulo
      t.text :descripcion

      t.timestamps null: false
    end
  end
end
