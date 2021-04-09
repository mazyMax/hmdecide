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
        see_list = Array.new
        if see_string == "all"
            
            see_string = Post.find(creator_id).followers
            see_list = see_string.split(',')
            see_list << creator_id.to_s
            see_list = see_list.uniq
            puts "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}"
            puts see_list
            return see_list.join(",")

        else

            see_list = see_string.split(',')
            see_list << creator_id.to_s
            see_list = see_list.uniq
            puts "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}"
            puts see_list
            return see_list.join(",")

        end

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

    def self.recommend(unsorted_posts, looker_id)
        
    end

    #https://blog.csdn.net/wccxiaoan/article/details/7617415
    def self.calculate_distance(lat1,lng1,lat2,lng2)
        lat1 = lat1.to_f
        lng1 = lng1.to_f
        lat2 = lat2.to_f
        lng2 = lng2.to_f
        include Math
        lat_diff = (lat1 - lat2)*PI/180.0
        lng_diff = (lng1 - lng2)*PI/180.0
        lat_sin = Math.sin(lat_diff/2.0) ** 2
        lng_sin = Math.sin(lng_diff/2.0) ** 2
        first = Math.sqrt(lat_sin + Math.cos(lat1*PI/180.0) * Math.cos(lat2*PI/180.0) * lng_sin)
        result = Math.asin(first) * 2 * 6378137.0
        p result.to_f
    end

    # https://www.jb51.cc/ruby/274128.html
    # https://blog.csdn.net/xing102172/article/details/9163607
    # https://stackoverflow.com/questions/41419169/sort-list-of-objects-according-to-an-array-rails
    def self.sort_by_location(unsorted_posts, location)
        location_list = location.split(",")
        sort_hash = Hash.new
        Post.all.each do |p|
            if p.location != ""
                post_loction_list = p.location.split(",")
                sort_hash[p.id] = Post.calculate_distance(location_list[0], location_list[1],post_loction_list[0],post_loction_list[1])
            end
        end
        puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
        puts sort_hash.sort_by {|key,value| value}.to_s
        sort_id_array = sort_hash.sort_by {|key,value| value}.map {|row| row[0]}
        puts sort_id_array.to_s
        sorted_posts = Post.where(id: sort_id_array).index_by(&:id).values_at(*sort_id_array)
        return sorted_posts
        
    end


    #https://melvinchng.github.io/rails/SearchFeature.html#43-adding-a-simple-search-feature

    
end
