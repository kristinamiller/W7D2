class SessionsController < ApplicationController

  before_action :require_logged_out, only:[:new, :create]
  #so you can't go to the sign up page if you're logged in


  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:email]
    )
    #why don't we have a user params helper method here???? 

    if @user
      login(@user)
      redirect_to user_url(@user)
      #WHY IS THIS DOING THE EXACT SAME THING THAT THE USER CONTROLLER IS DOING???
    else
      @user = User.new(username: params[:user][:username])
      #WHAT IS GOING ON HERE???
      flash.now[:errors] = ["Invalid Credentials"]
      #what's the difference between this and the other one.
      render :new
      #why are we rendering new here?????????? 
    end
    
  end

  def destroy
    logout
    redirect_to new_session_url
    #logs out user, sends them to sign in page. 
  end



end
