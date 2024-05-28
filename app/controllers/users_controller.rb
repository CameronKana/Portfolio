class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]


  def new
     @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.user_id = current_user.id
    @user.save
    redirect_to users_path
  end


  def index
     @users = User.all
     @user = current_user
    # @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
     @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path
  end

  def destroy
  end

 private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end


  def is_matching_login_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
    redirect_to user_path(current_user.id)
    end
  end




end
