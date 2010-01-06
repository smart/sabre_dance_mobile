require 'rho/rhocontroller'

class SongController < Rho::RhoController

  #GET /Song
  def index
    @songs = Songr.find(:all, :order => "name")
    render
  end

  # GET /Song/{1}
  def show
    @song = Songr.find(@params['id'])
    render :action => :show
  end

  # GET /Song/new
  def new
    @song = Songr.new
    render :action => :new
  end

  # GET /Song/{1}/edit
  def edit
    @song = Songr.find(@params['id'])
    render :action => :edit
  end

  # POST /Song/create
  def create
    @song = Songr.new(@params['song'])
    @song.save
    redirect :action => :index
  end

  # POST /Song/{1}/update
  def update
    @song = Songr.find(@params['id'])
    @song.update_attributes(@params['song'])
    redirect :action => :index
  end

  # POST /Song/{1}/delete
  def delete
    @song = Song.find(@params['id'])
    @song.destroy
    redirect :action => :index
  end
end
