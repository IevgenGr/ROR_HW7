class CommentsController < ApplicationController
  before_action :set_post

  def index; end

  def create
    @comment = @post.comments.build comment_params
    if @comment.save
      flash[:success] = 'Comment created!'
      redirect_to post_path(@post)
    else
      @comments = Comment.order created_at: :desc
      render 'posts/show'
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if current_author.id == @comment.author_id
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to post_path(@comment.post), notice: 'Comment was successfully updated.' }
          format.json { render :show, status: :ok, location: @comment }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to edit_post_path(@post), notice: 'Another author'
    end
  end

  def publish_comment
    @comment = Comment.find(params[:id])
    @comment.published!
    redirect_to post_path(@comment.post)
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def update_profile
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to profile_index_path, notice: 'Profile was successfully updated.' }
      else
        format.html { render :index }
      end
    end
  end

  def destroy
    comment = @post.comments.find params[:id]
    comment.destroy
    flash[:success] = 'Comment deleted!'
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
