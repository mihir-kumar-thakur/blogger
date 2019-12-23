class PostsController < ApplicationController
  skip_before_action :authenticate_user!, raise: false, only: [:show]

  before_action :find_post, only: [:show, :edit, :update, :destroy]
  
  def index
    @posts = current_user.posts.paginate(page: params[:page])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.new(post_params)
 
    if @post.save
      flash[:notice] = "Post created successfully."
      redirect_to @post
    else
      render :new
    end
  end

  def show
    @commentable = params[:controller].singularize.classify.constantize.friendly.find(params[:id])
    @comments = @commentable.comments.arrange(:order => :created_at)
    @comment = Comment.new
  end

  def edit
  end

  def update
    @post.attributes = post_params
    if @post.save
      flash[:notice] = "Post updated successfully."
      redirect_to @post
    else
      render :new
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "#{@post.title} is destroyed."
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :published, :content, :image)
  end

  def find_post
    @post = Post.friendly.find(params[:id])
  end
end
