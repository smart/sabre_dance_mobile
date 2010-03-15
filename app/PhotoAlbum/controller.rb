require 'base_controller'
class PhotoAlbumController < BaseController

  def index
    toolbar("Photo Albums", :back => "Back")
    @photo_albums = PhotoAlbum.find(:all)
    render
  end

  # GET /PhotoAlbum/{1}
  def show
    @photo_album = PhotoAlbum.find(@params['id'])
    toolbar(@photo_album.title, :back => "Back")
    if @photo_album
      render :action => :show
    else
      redirect :action => :index
    end
  end

end
