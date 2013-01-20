class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password
  before_save { |user| user.email.downcase! }
  before_save :create_remember_token

  validates :name, :presence => true, :length => { :maximum => 50 }

  EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true, :format => { :with => EMAIL_FORMAT }, :uniqueness => { :case_sensitive => false }

  validates :password, :presence => true, :length => { :minimum => 6 }
  validates :password_confirmation, :presence => true

  has_many :posts, :dependent => :destroy

  def self.log(search)
    if search and !search.blank?
      Post.where('user_id = ? and (link LIKE ? or title LIKE ?)', 1, "%#{search}%", "%#{search}%")
    else
      Post.where('user_id = ? ', 1)
    end
  end

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
