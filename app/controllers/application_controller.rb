class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to view that page!"
    redirect_to(request.referrer || root_path)
  end
end
