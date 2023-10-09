class CreateChallenges < ActiveRecord::Migration[7.0]
  def change
    create_table :challenges do |t|
      t.primary_key :Challenge_id
      t.string :Name
      t.date :startDate
      t.date :EndDate

      t.timestamps
    end
  end
end
