class UsersController < ApplicationController
  #must be logged out to create new account
  before_action :require_logged_out, only: [:new, :create]

  #require to be logged in to make specific requests
  # before action :require_logged_in, only: [:update]

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
