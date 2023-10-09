class Challenge < ApplicationRecord
  has_one :challenge_genericlist
  has_many :challenge_trainees
  has_many :task, through: :challenge_genericlists
  has_many :trainee, through: :challenge_trainees
end
