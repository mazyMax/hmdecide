class HomeController < ApplicationController
  def index
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    puts params
    looker_id = -1
    if current_user != nil
      looker_id = current_user.id
    end
    @posts = Post.all
    @posts = Post.close_posts_using_time(@posts)
    
    if params[:search] != nil
      @posts = Post.do_search(@posts, params[:search])
      @posts = Post.visibility_filter(@posts, looker_id)
      @posts = Post.closed_filter(@posts, looker_id)
    elsif params[:location] != nil

      puts "########################################################"
      puts params[:location]
      @posts = Post.visibility_filter(@posts, looker_id)
      @posts = Post.closed_filter(@posts, looker_id)
      @posts = Post.sort_by_location(@posts, params[:location])


    elsif params[:follow] != nil

      @posts = Post.get_follows(@posts, looker_id)
      @posts = Post.visibility_filter(@posts, looker_id)
      @posts = Post.closed_filter(@posts, looker_id)

    elsif params[:popular] != nil

      @posts = Post.get_popular(@posts, looker_id)
      @posts = Post.visibility_filter(@posts, looker_id)
      @posts = Post.closed_filter(@posts, looker_id).take(8)

    else

      #recommend!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      puts "????????????????????????????????????????????????????????????????"
      puts params
      @posts = Post.visibility_filter(@posts, looker_id)
      @posts = Post.closed_filter(@posts, looker_id)
      @posts = Post.recommend(@posts, looker_id)

    end
    
  end

    
  def about
  end
end
