class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.primary_key :Task_id
      t.string :TaskName

      t.timestamps
    end
  end
end
