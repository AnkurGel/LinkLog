class Post < ActiveRecord::Base
  require 'nokogiri'
  require 'open-uri'
  attr_accessible :link, :title, :private, :important
  belongs_to :user
  before_save :create_title

  LINK_FORMAT = /https?:\/\/\S+\.\S+/
  validates :user_id, :presence => true
  validates :link,    :presence => true, :format => { :with => LINK_FORMAT, :message => "should start with http or https and end with TLD" },
  :uniqueness => true
  validates :title, :uniqueness => true

  default_scope :order => 'posts.created_at DESC'

  private
  def create_title
    if self.link and self.title.empty?
      doc = Nokogiri::HTML(open(self.link))
      doc.search('title').each{ |t| self.title = t.content }
    end
  end
end
