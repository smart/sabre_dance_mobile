require 'base_controller'
class PostController < BaseController

  #GET /Post
  def index
    toolbar("News", :back => "Back")
    @posts = Post.find(:all)
    render
  end

  def news
    toolbar("News", :back => "Back")
    @posts = Post.find_news(:all)
    render :action => :index
  end

  def tweets
    toolbar("Tweets", :back => "Back")
    @posts = Post.find_tweets(:all)
    render :action => :index
  end


end
