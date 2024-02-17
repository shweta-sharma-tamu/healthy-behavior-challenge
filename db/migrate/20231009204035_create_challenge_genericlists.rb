# frozen_string_literal: true

class CreateChallengeGenericlists < ActiveRecord::Migration[7.0]
  def change
    create_table :challenge_genericlists do |t|
      t.references :task, null: false, foreign_key: true
      t.references :challenge, null: false, foreign_key: true
      t.timestamps
    end
  end
end
