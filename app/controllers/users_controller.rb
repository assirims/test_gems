class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :show]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @ransack_users = User.ransack(params[:users_search], search_key: :users_search)
    @ransack_users.sorts = ['id asc'] if @ransack_users.sorts.empty?
    @users = @ransack_users.result.includes(:courses)
    @pagy, @users = pagy(@users, items: 5)
    authorize @users
  end

  def show
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
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit({role_ids: []})
  end

  def authorize_user
    authorize @user #  gem pundit
  end

end
