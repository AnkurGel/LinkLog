class Post < ActiveRecord::Base
  attr_accessible :link, :title
  belongs_to :user

  LINK_FORMAT = /https?:\/\/\S+/
  validates :user_id, :presence => true
  validates :link,    :presence => true, :format => { :with => LINK_FORMAT, :message => "should start with http or https" },
  :uniqueness => true
  validates :title, :uniqueness => true

  default_scope :order => 'posts.created_at DESC'
end
