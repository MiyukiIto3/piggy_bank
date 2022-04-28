class UsersController < ApplicationController
  before_action :authenticate_user!

  def account
    @user = User.find(current_user.id)
  end
end
