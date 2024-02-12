# frozen_string_literal: true

# app/controllers/view_trainees_controller.rb
class ViewTraineesController < ApplicationController
  def index
    @trainees = Trainee.all
  end

  # app/controllers/view_trainees_controller.rb
  def profile_details
    @trainee = Trainee.find(params[:id])
  end
end
