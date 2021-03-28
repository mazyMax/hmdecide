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
    
    #https://melvinchng.github.io/rails/SearchFeature.html#43-adding-a-simple-search-feature
    def self.search(content)
        if content == nil
            return Post.all
        end
        
        Post.where("post_id = ?", content)
        
        
    end
    
end
