class CommentsController < ApplicationController
  before_action :require_user, only: [:vote]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = session[:user_id]

    if @comment.save 
      flash[:notice] = 'Comment saved'
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:id])
    vote = Vote.new(voteable: comment, creator: current_user, vote: params[:vote])

    if vote.save
      flash[:notice] = 'Your vote was counted.'
      redirect_to :back
    else
      flash[:error] = "You can't vote twice."
      redirect_to :back
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end