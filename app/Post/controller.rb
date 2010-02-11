require 'rho/rhocontroller'

class PostController < Rho::RhoController

  #GET /Post
  def index
    @posts = Postr.find(:all)
    render
  end

  def news
    @posts = Postr.find_news(:all)
    render :action => :index
  end

  def tweets
    @posts = Postr.find_tweets(:all)
    render :action => :index
  end

  # GET /Post/{1}
  def show
    @post = Postr.find(@params['id'])
    if @post
      render :action => :show
    else
      redirect :action => :index
    end
  end

  # GET /Post/new
  def new
    @post = Post.new
    render :action => :new
  end

  # GET /Post/{1}/edit
  def edit
    @post = Post.find(@params['id'])
    if @post
      render :action => :edit
    else
      redirect :action => :index
    end
  end

  # POST /Post/create
  def create
    @post = Post.new(@params['post'])
    @post.save
    redirect :action => :index
  end

  # POST /Post/{1}/update
  def update
    @post = Post.find(@params['id'])
    @post.update_attributes(@params['post']) if @post
    redirect :action => :index
  end

  # POST /Post/{1}/delete
  def delete
    @post = Post.find(@params['id'])
    @post.destroy if @post
    redirect :action => :index
  end
end
