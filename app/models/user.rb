class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_voter
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :choices
    #def show
     # @posts = current_user.posts.order(created_at: :desc)
    #end

  def self.operate_follow(follow_user, creater_of_the_post)
    if follow_user.id != creater_of_the_post.id
      # edit follow_user's data
      user_follows_list = follow_user.follows
      user_follows_list = user_follows_list.split(",")
      user_follows_list << creater_of_the_post.id.to_s
      user_follows_list = user_follows_list.uniq
      follow_user.update({"follows": user_follows_list.join(",")})
      
      # edit creater_of_the_post's data
      creater_follower_list = creater_of_the_post.followers
      creater_follower_list = creater_follower_list.split(",")
      creater_follower_list << follow_user.id.to_s
      creater_follower_list = creater_follower_list.uniq
      creater_of_the_post.update({"followers": creater_follower_list.join(",")})

      # puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      # puts follow_user.id.to_s + "  follows  " + creater_of_the_post.id.to_s


    end
  end


  def self.operate_unfollow(follow_user, creater_of_the_post)
    if follow_user.id != creater_of_the_post.id
      # edit follow_user's data
      user_follows_list = follow_user.follows
      user_follows_list = user_follows_list.split(",")
      user_follows_list.delete(creater_of_the_post.id.to_s)
      user_follows_list = user_follows_list.uniq
      follow_user.update({"follows": user_follows_list.join(",")})

      
      # edit creater_of_the_post's data
      creater_follower_list = creater_of_the_post.followers
      creater_follower_list = creater_follower_list.split(",")
      creater_follower_list.delete(follow_user.id.to_s)
      creater_follower_list = creater_follower_list.uniq
      creater_of_the_post.update({"followers": creater_follower_list.join(",")})

      # puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      # puts follow_user.id.to_s + "  unfollows  " + creater_of_the_post.id.to_s

    end


  end




end
