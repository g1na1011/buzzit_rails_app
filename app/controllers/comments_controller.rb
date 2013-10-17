class CommentsController < ApplicationController
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

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end