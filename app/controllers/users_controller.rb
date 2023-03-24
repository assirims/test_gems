class UsersController < ApplicationController
  def index
    # @users = User.all.order(created_at: :desc)
    # @q = User.ransack(params[:q])
    # @users = @q.result(distinct: true)
    @ransack_users = User.ransack(params[:users_search], search_key: :users_search)
    @ransack_users.sorts = ['id desc'] if @ransack_users.sorts.empty?
    @users = @ransack_users.result.includes(:courses)
  end
end
