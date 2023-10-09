class CreateChallengeGenericlists < ActiveRecord::Migration[7.0]
  def change
    create_table :challenge_genericlists do |t|
      t.references :Task, null: false, foreign_key: true
      t.references :challenge, null: false, foreign_key: true

      t.timestamps
    end
  end
end
