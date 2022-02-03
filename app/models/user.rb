class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.to_s.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find {|user| user.slug == slug}
  end
  
  def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end

end
