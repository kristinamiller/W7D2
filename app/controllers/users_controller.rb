class UsersController < ApplicationController

  #before_action :require_logged_in, only: [:index, :show]
  #makes sure the user is logged in before running any of these methods?
  #or is that only for the index and show methods??

  def new
    @user = User.new
    #why do we need this??
    render :new
    #renders new view page
  end

  def index
    @users = User.all
    render :index
    #sets users instance variable so we can access it in views
    #renders index view page
  end

  def show
    render :show
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new

      #make them try again. show error messages
      #set flash hash to error message
      #render json: user.errors.full_messages
    end
  end

  def edit
    @user = User.find(params[:id])
    render :edit
    #WHY IS THIS FIND AND NOT FIND_BY????
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_url(@user) 
    else
      render json: @user.full_error_messages, status: 422
    end
    #finds the user
  end



  private
  def user_params
    params.require(:users).permit(:email, :password)
  end

end
