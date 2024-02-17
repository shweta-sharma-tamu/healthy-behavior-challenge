# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :user_signed_in?

  def user_signed_in?
    session[:user_id].present?
  end
end
