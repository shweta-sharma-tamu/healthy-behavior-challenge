# frozen_string_literal: true

class Trainee < ApplicationRecord
  belongs_to :user

  validates :full_name, presence: true
  validates :height, presence: true, numericality: { greater_than: 0 }
  validates :weight, presence: true, numericality: { greater_than: 0 }

  has_many :challenge_trainees
  has_many :todolist_tasks
  has_many :challenges, through: :challenge_trainees
end
