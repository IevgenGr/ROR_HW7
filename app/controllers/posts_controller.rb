class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorize, only: %i[create update destroy]
  before_action :counter_view, only: %i[show index]
  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comment = @post.comments.build
  end

  # GET /posts/new
  def search
    @posts = Post.where('title||content ILIKE?', '%' + params[:q] + '%')
  end

  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    if current_author.id == @post.author_id
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to edit_post_path(@post), notice: 'Another author'
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content, :image, :author_id, :count_view)
  end

  def counter_view
    if cookies[:counter_view].nil?
      cookies[:counter_view] = 1
    else
      var_counter_view = cookies[:counter_view].to_i
      var_counter_view += 1
      cookies[:counter_view] = var_counter_view
    end
  end
end
