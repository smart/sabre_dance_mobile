class Post

  def self.find_tweets(first, opts ={})
    opts.merge!(:conditions => {:post_type => "Tweet"})
    find(first, opts)
  end

  def self.find_news(first, opts = {})
    opts.merge!(:conditions => {:post_type => "Offical News"})
    find(first, opts)
  end

end