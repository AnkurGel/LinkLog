class PostsController < ApplicationController
  before_filter :signed_in_user, :only => [:create, :destroy]

  def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "Link saved!"
      redirect_to root_url
    else
      # in case fails the validation or not saved.
      render 'default_pages/home'
    end
  end

  def destroy
    @post = current_user.posts.find_by_id(params[:id])
    if @post.nil?
      redirect_to root_url
    else
      @post.destroy
      flash[:success] = "Link deleted."
      redirect_to root_path
    end
  end

    private
    def signed_in_user
      redirect_to root_path unless signed_in?
    end
end
