class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :set_global_search_variable, if: :user_signed_in?
  def set_global_search_variable
    @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search) #navbar search
    @ransack_users = User.ransack(params[:users_search], search_key: :users_search) #navbar search
  end

  include PublicActivity::StoreController #save current_user using gem public_activity
end
