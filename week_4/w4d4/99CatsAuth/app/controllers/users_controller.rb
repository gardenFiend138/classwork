class UsersController < ApplicationController
  #must be logged out to create new account
  before_action :require_logged_out, only: [:new, :create]

 # This is showing us a new user login page
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
      # What is it that we're rendering here?
      # I'm assuming it's a new users_url page,
      # but how can we just put :new? Becasue we defined it above;
      # But even in that method, how can we call the url path/ prefix
      # 'new' as a symbol? Or is that what we're even doing, since
      # everywhere else, we are sending to the url prefix....?
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
