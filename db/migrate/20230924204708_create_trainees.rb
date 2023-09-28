class CreateTrainees < ActiveRecord::Migration[7.0]
    def change
      create_table :trainees do |t|
        t.string :full_name
        t.float :height
        t.float :weight
        t.references :user, foreign_key: true
  
        t.timestamps
      end
    end
end