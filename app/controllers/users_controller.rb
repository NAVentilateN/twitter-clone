class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # Debugger will open a debugger byebug console panel in the IDE
    # debugger
    @posts = @user.posts
    @post = Post.new
  end

  private
end
