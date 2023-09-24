class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string "email"
      t.string "password_digest"
      t.string "user_type"
      t.integer "user_id"
      t.timestamps
    end
  end
end
