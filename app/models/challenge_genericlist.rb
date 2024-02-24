# frozen_string_literal: true

class ChallengeGenericlist < ApplicationRecord
  belongs_to :task
  belongs_to :challenge
end
