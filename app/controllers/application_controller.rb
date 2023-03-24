class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:privacy_policy]

  before_action :set_global_search_variable, if: :user_signed_in?
  def set_global_search_variable
    @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search) #navbar search
    @ransack_users = User.ransack(params[:users_search], search_key: :users_search) #navbar search
  end

end
