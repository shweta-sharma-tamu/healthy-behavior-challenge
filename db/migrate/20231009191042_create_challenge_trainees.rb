# frozen_string_literal: true

class CreateChallengeTrainees < ActiveRecord::Migration[7.0]
  def change
    create_table :challenge_trainees do |t|
      t.references :trainee, null: false, foreign_key: true
      t.references :challenge, null: false, foreign_key: true
      t.timestamps
    end
  end
end
