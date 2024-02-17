# frozen_string_literal: true

class ViewTraineesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :trainee_not_found

  def index
    @trainees = Trainee.all
    @trainees_present = @trainees.exists?
  end

  def profile_details
    @trainee = Trainee.find_by(id: params[:id])
    return if @trainee

    flash[:alert] = 'Trainee not found.'
    redirect_to view_trainees_path
    nil
  end

  def trainee_not_found
    flash[:alert] = 'Trainee not found.'
    redirect_to view_trainees_path
  end
end
