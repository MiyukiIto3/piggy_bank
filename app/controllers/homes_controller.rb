class HomesController < ApplicationController
  def top
  end

  def select_kid
    @user = User.find(current_user.id)
    @kids = @user.kids
    @post = Post.new
  end

  def select_type
    @post = Post.new(post_params)
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :kid_id, :date, :post_type, :amount, :description)
  end
end
