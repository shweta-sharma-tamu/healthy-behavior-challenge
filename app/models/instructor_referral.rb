class InstructorReferral < ApplicationRecord
  belongs_to :user
  validates :email, presence: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
 