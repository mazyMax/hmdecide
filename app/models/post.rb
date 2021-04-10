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

    # def self.who_can_see_preprocess(creator_id, see_string)
    #     see_list = Array.new
    #     if see_string == "all"
            
    #         see_string = Post.find(creator_id).followers
    #         see_list = see_string.split(',')
    #         see_list << creator_id.to_s
    #         see_list = see_list.uniq
    #         puts "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}"
    #         puts see_list
    #         return see_list.join(",")

    #     else

    #         see_list = see_string.split(',')
    #         see_list << creator_id.to_s
    #         see_list = see_list.uniq
    #         puts "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}"
    #         puts see_list
    #         return see_list.join(",")

    #     end

    # end

    def self.closed_filter(unfiltered_posts, looker_id)
        remain_posts = unfiltered_posts
        unfiltered_posts.each do |p|
            if p.close == 1
                remain_posts = remain_posts - Post.where("id = ?", p.id)
            end
        end
        return remain_posts
    end

    def self.do_search(unfiltered_posts, search_content)
        remain_posts = unfiltered_posts
        description_result = Post.where(["description LIKE ?","%#{search_content}%"]).order(created_at: :desc)
        tags_result = Post.where(["hash_tags LIKE ?","%#{search_content}%"]).order(created_at: :desc)
        return (description_result + tags_result).uniq
    end


    def self.close_posts_using_time(unfiltered_posts)
        remain_posts = unfiltered_posts
        unfiltered_posts.each do |p|
            puts p.created_at.class
            puts "created at"
            puts p.created_at
            puts "now"
            puts Time.zone.now
            puts "existing time"
            puts Time.zone.now - p.created_at
            puts (Time.zone.now - p.created_at)/60
            puts "post existing time"
            puts p.existingtime
            puts p.existingtime.to_f
            if p.existingtime != ""
                if p.existingtime.to_f < (Time.zone.now - p.created_at)/60
                    Post.where("id = ?", p.id).update({"close": 1})
                    remain_posts = remain_posts - Post.where("id = ?", p.id)
                end
            end
        end
        return remain_posts

    end

    def self.visibility_filter(unfiltered_posts, looker_id)
        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        puts looker_id
        remain_posts = unfiltered_posts
        unfiltered_posts.each do |p|
            puts p.visibility
            puts p.class
            if p.visibility == "private" and looker_id != p.user_id
                remain_posts = remain_posts - Post.where("id = ?", p.id)
            elsif p.visibility == "follow" and looker_id != p.user_id
                follower_list = User.find(p.user_id).followers.split(",")
                if !(follower_list.include?(looker_id.to_s))
                    remain_posts = remain_posts - Post.where("id = ?", p.id)
                end
                # see_list = p.who_can_see.split(',')

                # puts "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
                # puts see_list
                # if !(see_list.include?(looker_id.to_s))
                #     puts Post.where("id = ?", p.id).take.description
                #     remain_posts = remain_posts - Post.where("id = ?", p.id)
                # end
                # #followers!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

            end
        end

        return remain_posts
    end

    def self.recommend(unrecommended_posts, looker_id)
        puts unrecommended_posts
        if looker_id == -1
            return unrecommended_posts
        else
            follows = User.find(looker_id).follows
            follows_list = follows.split(",").map {|a| a.to_i}
            puts follows_list.to_s
            puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"

            remain_posts = unrecommended_posts

            first_3_emergency = unrecommended_posts.sort_by{|u| u.created_at}.reverse.take(3)
            remain_posts -= first_3_emergency

            first_5_follows = Post.where(user_id: follows_list).order(created_at: :desc)
            first_5_follows = Post.visibility_filter(first_5_follows, looker_id)
            first_5_follows = Post.closed_filter(first_5_follows, looker_id).take(5)
            remain_posts -= first_5_follows

            first_3_popular = remain_posts.sort_by{|u| u.vote_count}.reverse.take(3)
            remain_posts -= first_3_popular
 
            return (first_3_emergency + first_3_popular + first_5_follows + remain_posts).uniq
            
        end
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
        unsorted_posts.each do |p|
            if p.location != nil
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

    def self.get_follows(unchosen_posts, looker_id)
        if looker_id == -1
            return unchosen_posts
        else
            follows = User.find(looker_id).follows
            follows_list = follows.split(",").map {|a| a.to_i}
            return Post.where(user_id: follows_list).order(created_at: :desc)
        end
    end

    def self.get_popular(unchosen_posts, looker_id)
        if looker_id == -1
            return unchosen_posts
        else
            return unchosen_posts.sort_by{|u| u.vote_count}.reverse
        end
    end


    #https://melvinchng.github.io/rails/SearchFeature.html#43-adding-a-simple-search-feature

    
end
