class DefaultPagesController < ApplicationController
  def home
    if signed_in?
      @post = current_user.posts.build
    end
    @logged_links = User.log(params[:search]).paginate(:page => params[:page], :per_page => 8)
    flash.now[:error] = "No entry in your log matches \"#{params[:search]}\"" if @logged_links.empty?
    if params[:search] and not params[:search].empty? and not @logged_links.empty?
      flash.now[:success] = "Showing #{@logged_links.length} results for \"#{params[:search]}\"."
    end
  end

  def about
  end
end
