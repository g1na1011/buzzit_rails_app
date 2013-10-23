class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show, :edit]
  before_action :match_post_user, only: [:edit]

  def index
    @posts = Post.all.sort_by { |post| post.total_votes }.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create 
    @post = Post.new(post_params)
    @post.user_id = session[:user_id]

    if @post.save
      flash[:notice] = 'Your post was saved.'
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Your post was updated.'
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def match_post_user
    if session[:user_id] != @post.user_id
      flash[:error] = 'You are not the creator.'
      redirect_to post_path(@post)
    end
  end

  def vote
    vote = Vote.new(voteable: @post, creator: current_user, vote: params[:vote])

    respond_to do |format|
      format.html { 
        if vote.save
          flash[:notice] = 'Your vote was counted.'
          redirect_to :back
        else
          flash[:error] = "You can't vote twice."
          redirect_to :back
        end
      }
      format.js
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:url, :title, :description, category_ids: [])
    end

    def set_post
      @post = Post.find(params[:id])
    end
end
