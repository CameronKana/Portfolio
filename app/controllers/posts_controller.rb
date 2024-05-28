class PostsController < ApplicationController
  before_action  :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  def new
    @post = Post.new

  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end



  def index
     @posts = Post.all
     @user = current_user
    # @book = Book.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to posts_path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

 private

  def post_params
    params.require(:post).permit(:shop_name, :image, :caption)
  end

  def is_matching_login_user
    @post = Post.find(params[:id])
    if @post.user_id != current_user.id
    redirect_to posts_path
    end
  end


end

