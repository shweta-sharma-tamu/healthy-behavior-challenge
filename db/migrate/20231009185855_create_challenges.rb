class CreateChallenges < ActiveRecord::Migration[7.0]
  def change
    create_table :challenges do |t|
      t.string :name
      t.date :startDate
      t.date :endDate
      t.timestamps
    end
  end
end
