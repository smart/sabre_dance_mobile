require 'rho/rhocontroller'

class PhotoAlbumController < Rho::RhoController
  layout :photo
  @layout = 'photo'

  #GET /PhotoAlbum
  def index
    @photo_albums = PhotoAlbumr.find(:all)
    render
  end

  # GET /PhotoAlbum/{1}
  def show
    p "LAYOUT"
    p self.class.get_layout_name
    @photo_album = PhotoAlbumr.find(@params['id'])
    if @photo_album
      p "SHHOULD BE RENDERING"
      render :action => :show, :layout => "photo"
    else
      redirect :action => :index
    end
  end

  # GET /PhotoAlbum/new
  def new
    @photo_album = PhotoAlbum.new
    render :action => :new
  end

  # GET /PhotoAlbum/{1}/edit
  def edit
    @photo_album = PhotoAlbum.find(@params['id'])
    if @photo_album
      render :action => :edit
    else
      redirect :action => :index
    end
  end

  # POST /PhotoAlbum/create
  def create
    @photo_album = PhotoAlbum.new(@params['photo_album'])
    @photo_album.save
    redirect :action => :index
  end

  # POST /PhotoAlbum/{1}/update
  def update
    @photo_album = PhotoAlbum.find(@params['id'])
    @photo_album.update_attributes(@params['photo_album']) if @photo_album
    redirect :action => :index
  end

  # POST /PhotoAlbum/{1}/delete
  def delete
    @photo_album = PhotoAlbum.find(@params['id'])
    @photo_album.destroy if @photo_album
    redirect :action => :index
  end
end
