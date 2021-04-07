class Post < ApplicationRecord
    belongs_to :user
    has_many :choices
    has_one_attached :image
    accepts_nested_attributes_for :choices, allow_destroy: true
    
    
    validate :image_presence
    
    def image_presence
        errors.add(:image, "can't be blank") unless image.attached?
    end
    
    def self.Corresponding_Choices(post_id)
        return Choice.where("post_id = ?", post_id)
    end
    
    def self.Corresponding_Posts(user_id)
        return Post.where("user_id = ?", user_id)
    end

    def self.visibility_filter(unfiltered_posts, looker_id)
        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        puts looker_id
        if looker_id == -1
            unfiltered_posts.each do |p|
                puts p.visibility
                puts p.class
                if p.visibility == "private"
                    unfiltered_posts = unfiltered_posts - Post.where("id = ?", p.id)
                elsif p.visibility == "followers"
                    #followers!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                end
            end
        else
        end
        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        puts unfiltered_posts.class
        return unfiltered_posts
    end


    #https://melvinchng.github.io/rails/SearchFeature.html#43-adding-a-simple-search-feature

    
end
