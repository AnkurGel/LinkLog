class DefaultPagesController < ApplicationController
  def home
    if signed_in?
      @post = current_user.posts.build
      @tag = ActsAsTaggableOn::Tag.new
    end

    if params[:tag]
      @logged_links = User.log(params[:search]).tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 8)
    else
      @logged_links = User.log(params[:search]).paginate(:page => params[:page], :per_page => 8)
    end
    flash.now[:error] = "No entry in your log matches \"#{params[:search]}\"" if @logged_links.empty?
    if params[:search] and not params[:search].empty? and not @logged_links.empty?
      flash.now[:success] = "Showing #{@logged_links.length} results for \"#{params[:search]}\"."
    end
  end

  def about
  end

  def create_tag
    if params[:tag]["name"]
      @tag = ActsAsTaggableOn::Tag.new(:name => params[:tag]["name"].downcase)
      unless @tag.save
        flash[:error] = "Problem in creating tag. It may already exist"
      end
    end
    redirect_to root_path
  end
end
