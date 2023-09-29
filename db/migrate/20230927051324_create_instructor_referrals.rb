class CreateInstructorReferrals < ActiveRecord::Migration[7.0]
  def change
    create_table :instructor_referrals do |t|
      t.string :token, limit: 40
      t.datetime :expires
      t.boolean :is_used
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :instructor_referrals, :token, unique: true
  end
end
