# frozen_string_literal: true

class AddEmailToInstructorReferrals < ActiveRecord::Migration[7.0]
  def change
    add_column :instructor_referrals, :email, :string
  end
end
