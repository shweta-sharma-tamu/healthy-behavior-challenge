# frozen_string_literal: true

class CreateTodolistTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :todolist_tasks do |t|
      t.references :task, null: false, foreign_key: true
      t.string :status
      t.references :trainee, null: false, foreign_key: true
      t.references :challenge, null: false, foreign_key: true
      t.date :date
      t.timestamps
    end
  end
end
