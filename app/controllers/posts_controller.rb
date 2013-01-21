class PostsController < ApplicationController
  before_filter :signed_in_user, :only => [:create, :destroy]

  def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "Link saved!"
      redirect_to root_url
    else
      # in case fails the validation or not saved.
      @logged_links = User.log.paginate(:page => params[:page], :per_page => 8)
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

  def tags
    @tags = ActsAsTaggableOn::Tag.where("tags.name LIKE ?", "%#{params[:q]}%")
    respond_to do |format|
#      format.json { render :json => @tags.map{|t| {:id => t.name, :name => t.name }}}
      format.json { render :json => @tags.collect{|t| {:id => t.name, :name => t.name }}}
    end
  end
    private
    def signed_in_user
      redirect_to root_path unless signed_in?
    end
end
