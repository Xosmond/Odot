class CreateTodoLists < ActiveRecord::Migration[5.1]
  def change
    create_table :todo_lists do |t|
      t.string :title
      t.text :description
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
