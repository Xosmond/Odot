class CreateTodoItems < ActiveRecord::Migration[5.1]
  def change
    create_table :todo_items do |t|
      t.references :todo_list, index: true, foreign_key: true
      t.string :content
      t.datetime :completed_at
      t.timestamps null: false
    end
  end
end
