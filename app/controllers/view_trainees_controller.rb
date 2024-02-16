# frozen_string_literal: true

class ViewTraineesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :trainee_not_found

  def index
    @trainees = Trainee.all
    @trainees_present = @trainees.exists?
  end

  def profile_details
    @trainee = Trainee.find_by(id: params[:id])
    unless @trainee
      redirect_to view_trainees_path, alert: 'Trainee not found.'
      return
    end
  end

  def trainee_not_found
    redirect_to view_trainees_path, alert: 'Trainee not found.'
  end
end
