class CommentsController < ApplicationController
  before_action :set_post

  def index
    @comments = Comment.published
    redirect_to post_path(@post, @comments)
  end

  def create
      @comment = @post.comments.build comment_params
      if @comment.save
        flash[:success] = "Comment created!"
        redirect_to post_path(@post)
      else
        @comments = Comment.order created_at: :desc
        render 'posts/show'
      end
  end

  def update;
    @comment = Comment.find(params[:id])
    @comment.published!
    redirect_to post_path(@comment.post)
  end

  def show;
  end



  def destroy
    comment = @post.comments.find params[:id]
    comment.destroy
    flash[:success] = "Comment deleted!"
    redirect_to post_path(@post)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:body, :status, :author_id, :post_id, :count_view)
  end


  def set_post
    @post = Post.find params[:post_id]
  end


end

