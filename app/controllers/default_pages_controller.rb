class DefaultPagesController < ApplicationController
  def home
    if signed_in?
      @post = current_user.posts.build
    end
    @logged_links = User.log(params[:search]).paginate(:page => params[:page], :per_page => 8)
  end

  def about
  end
end
