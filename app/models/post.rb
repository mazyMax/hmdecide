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

    def self.who_can_see_preprocess(creator_id, see_string)
        see_list = see_string.split(',')
        see_list << creator_id.to_s
        see_list = see_list.uniq
        return see_list.join(",")
    end

    def self.visibility_filter(unfiltered_posts, looker_id)
        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        puts looker_id
        
        unfiltered_posts.each do |p|
            puts p.visibility
            puts p.class
            if p.visibility == "private" and looker_id != p.user_id
                unfiltered_posts = unfiltered_posts - Post.where("id = ?", p.id)
            elsif p.visibility == "follow"
                see_list = p.who_can_see.split(',')

                puts "!!!!!!!"
                puts see_list
                if !(see_list.include?(looker_id.to_s))
                    puts Post.where("id = ?", p.id)
                    unfiltered_posts = unfiltered_posts - Post.where("id = ?", p.id)
                end
                #followers!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

            end
        end
        puts "!```````````````````!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!```````````````````"

        return unfiltered_posts
    end

    def self.add_to_block_list(unfiltered_posts)

    end

    #https://melvinchng.github.io/rails/SearchFeature.html#43-adding-a-simple-search-feature

    
end
