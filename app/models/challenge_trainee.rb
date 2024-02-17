# frozen_string_literal: true

class ChallengeTrainee < ApplicationRecord
  belongs_to :trainee
  belongs_to :challenge
end
