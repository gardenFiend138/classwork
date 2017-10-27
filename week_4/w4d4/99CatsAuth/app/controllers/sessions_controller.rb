class SessionsController < ApplicationController
  #must be lgoged out to start new session
  before_action :require_logged_out, only: [:new, :create]

  #only allow you to destroy seesion e.g. logout when you're logged in
  # before action :require_logged_in, only: [:destroy]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if user.nil?
      flash.now[:errors] = ["Didja forget your password or username?"]
      render :new
    else
      login!(user)
      redirect_to cats_url
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

end
