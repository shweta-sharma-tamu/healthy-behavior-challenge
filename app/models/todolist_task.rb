class TodolistTask < ApplicationRecord
  belongs_to :task
  belongs_to :trainee
  belongs_to :challenge

  # Assuming you have a 'status' column in the TodolistTask table
  enum status: { completed: 'completed', not_completed: 'not_completed' }

end
