class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :owned_post, only: [:edit, :update, :destroy]



  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Your post has been created!"
      redirect_to posts_path
    else
      flash.now[:alert] = "Your new post couldn't be created! Are you missing something?"
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = 'Post updated!'
      redirect_to(posts_path(@post))
    else
      flash.now[:alert] = "Update has failed. Did you forget to add something?"
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = 'Post deleted!'
      redirect_to posts_path
    else
      flash[:alert] = 'Oh no! Something went wrong!'
      render :new
    end
  end

  private

  def owned_post
    unless current_user == @post.user
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
