class Trainee < ApplicationRecord
    belongs_to :user
  
    validates :full_name, presence: true
    validates :height, presence: true, numericality: { greater_than: 0 }
    validates :weight, presence: true, numericality: { greater_than: 0 }

    has_many :challenge_trainee
    has_many :todolist_task
    has_many :challenge, through: :challenge_trainee  
end