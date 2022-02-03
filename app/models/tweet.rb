class Tweet < ActiveRecord::Base
  belongs_to :user

  def self.current_user
    Tweet.find(session[:user_id])
  end

end
