# frozen_string_literal: true

class AddInstructorToChallenges < ActiveRecord::Migration[7.0]
  def change
    add_reference :challenges, :instructor, null: true, foreign_key: true
  end
end
