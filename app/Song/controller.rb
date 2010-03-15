require 'base_controller'
class SongController < BaseController

  #GET /Song
  def index
    toolbar("Songs", :back => "Back")
    @songs = Song.find(:all, :order => "name")
    render
  end

  # GET /Song/{1}
  def show
    @song = Song.find(@params['id'])
    toolbar(@song.name, :back => "Back")
    render :action => :show
  end

end
