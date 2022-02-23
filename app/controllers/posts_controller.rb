class PostsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :index ]
  def index
    @posts = Post.all
  end

  def new
    @post = Post.neq
  end

  def create
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
  end

  def delete
    @post = Post.find(params[:id])
    @post.destroy
  end
end
