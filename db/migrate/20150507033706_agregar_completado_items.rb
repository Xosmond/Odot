class AgregarCompletadoItems < ActiveRecord::Migration
  def change
  	add_column :todo_items,:completado_en,:datetime
  end
end
