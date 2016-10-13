class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
      @post = Post.find(params[:id])
    if @post.user == current_user
      @post.update(post_params)
    else
      flash[:alert] = "You can't edit someone else's post!"
    end
      redirect_to posts_path(@post)
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.where(:post_id => @post.id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create!(post_params.merge(user: current_user))
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
    else
      flash[:alert] = "You can't delete someone else's post."
    end
      redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title,:body)
  end
end
