class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  def index
    # @users = User.all.order(created_at: :desc)
    # @q = User.ransack(params[:q])
    # @users = @q.result(distinct: true)
    @ransack_users = User.ransack(params[:users_search], search_key: :users_search)
    @ransack_users.sorts = ['id desc'] if @ransack_users.sorts.empty?
    @users = @ransack_users.result.includes(:courses)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: 'User was successfully destroyed.'
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit({role_ids: []})
  end

end
