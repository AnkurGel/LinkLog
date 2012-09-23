class DefaultPagesController < ApplicationController
  def home
    if signed_in?
      @post = current_user.posts.build
    end
    @logged_links = User.log.paginate(:page => params[:page])
  end

  def about
  end
end
