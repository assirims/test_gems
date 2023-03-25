class ApplicationController < ActionController::Base
  before_action :authenticate_user! #gem devise

  include Pundit::Authorization #gem pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized #gem pundit

  before_action :set_global_search_variable, if: :user_signed_in? #navbar search

  include PublicActivity::StoreController #save current_user using gem public_activity

  private
  def set_global_search_variable #navbar search
    @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search) #navbar search
    @ransack_users = User.ransack(params[:users_search], search_key: :users_search) #navbar search
  end

  def user_not_authorized #gem pundit
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end
end
