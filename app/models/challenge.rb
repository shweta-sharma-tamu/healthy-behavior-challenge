class Challenge < ApplicationRecord
  has_one :challenge_genericlist
  has_many :challenge_trainees
  has_many :tasks, through: :challenge_genericlist
  has_many :trainees, through: :challenge_trainees
end
