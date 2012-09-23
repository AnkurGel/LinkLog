class Post < ActiveRecord::Base
  attr_accessible :link, :title
  belongs_to :user

  validates :user_id, :presence => true
  validates :link,    :presence => true

  default_scope :order => 'posts.created_at DESC'
end
