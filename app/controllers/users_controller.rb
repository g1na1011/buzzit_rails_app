class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :same_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = 'Your account is created.'
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Your profile is updated.'
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def same_user
    if current_user.id != @user.id
      flash[:error] = "You can't do that."
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :time_zone, :role)
  end

  def set_user
    @user = User.find_by(slug: params[:id])
  end
end