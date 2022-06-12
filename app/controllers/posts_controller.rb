class PostsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [ :index ]

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:alert] = "Post created!"
    else
      flash[:alert] = "Content Required!"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @post = Post.find(params[:id])

    @post.destroy if @post.user == current_user
    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:description, :picture)
  end
end
