class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i(show edit update destroy)

  # GET /posts or /posts.json
  def index
    @post = Post.new(post_params)
    @kid = Kid.find(@post.kid_id)

    @q = Post.where(kid_id: @post.kid_id).order(date: :desc).ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).per(10)

    @total_income = Post.where(kid_id: @post.kid_id).where(post_type: "income").sum(:amount)
    @total_outgo = Post.where(kid_id: @post.kid_id).where(post_type: "outgo").sum(:amount)
    @total_amount = @total_income - @total_outgo

    if @kid.target_amount > @total_amount
      @shortage = @kid.target_amount - @total_amount
      @message = "あと#{@shortage.to_s(:delimited)}円で、#{@kid.target} が買えます。"
    else
      @message = "#{@kid.target}が買えます。"
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    @kid = Kid.find(@post.kid_id)
  end

  # GET /posts/new
  def new
    @post = Post.new(post_params)
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "登録しました。" }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "更新しました。" }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to homes_select_kid_path, notice: "削除しました。" }
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
    params.require(:post).permit(:user_id, :kid_id, :date, :post_type, :amount, :description)
  end
end
