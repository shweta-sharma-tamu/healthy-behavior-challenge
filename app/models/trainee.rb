class Trainee < ApplicationRecord
    belongs_to :user # A trainee profile belongs to a user
  
    validates :full_name, presence: true
    validates :height, presence: true, numericality: { greater_than: 0 }
    validates :weight, presence: true, numericality: { greater_than: 0 }
end