# frozen_string_literal: true

class Task < ApplicationRecord
  has_many :todolist_tasks
end
