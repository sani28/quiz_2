class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email(params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Logged In Successfully"
      redirect_to ideas_path
    else
      flash[:alert] = 'Problem loggin in, please try again!'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to ideas_path, notice: "Logged Out!"
  end

end #sessions end
