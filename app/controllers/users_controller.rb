class UsersController < ApplicationController
  before_action :require_login, except: [:show, :create, :new, :index]

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    if current_user
      flash[:error] = "Already logged in."
      redirect_to root_url
      return
    end

    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to @user, notice: "Account created!"
    else
      flash.now[:error] = "Account could not be created."
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    # @following = @user.followings.first
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to root_url, notice: "Account destroyed!"
    else
      flash[:error] = "Account could not be destroyed."
      redirect_to root_url
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      sign_in(@user)
      redirect_to @user, notice: "Account updated!"
    else
      flash.now[:error] = "Account could not be updated."
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
