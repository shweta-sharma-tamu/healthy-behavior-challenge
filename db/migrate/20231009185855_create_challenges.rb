# frozen_string_literal: true

class CreateChallenges < ActiveRecord::Migration[7.0]
  def change
    create_table :challenges do |t|
      t.string :name, null: false
      t.date :startDate, null: false
      t.date :endDate, null: false
      t.timestamps
    end
  end
end
