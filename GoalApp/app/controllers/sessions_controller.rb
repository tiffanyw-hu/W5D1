class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      sign_in(@user)
      redirect_to root_url
    else
      flash[:errors] = [ "Invalid username and password" ]
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
