class Challenge < ApplicationRecord
  has_many :challenge_genericlist
  has_many :challenge_trainees
  has_many :tasks, through: :challenge_genericlist
  has_many :trainees, through: :challenge_trainees
  accepts_nested_attributes_for :tasks, allow_destroy: true
  belongs_to :instructor
end
