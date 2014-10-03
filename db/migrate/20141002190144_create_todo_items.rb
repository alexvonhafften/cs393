class CreateTodoItems < ActiveRecord::Migration
  def change
    create_table  :todo_items do |table|
      table.string :description
      table.string :due_date
      # id column is automatically added by activerecord
    end
  end
end
