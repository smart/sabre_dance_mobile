require 'rho/rhocontroller'

class SetListController < Rho::RhoController

  #GET /SetList
  def index
    @setlists = SetList.find(:all)
    render
  end

  # GET /SetList/{1}
  def show
    @setlist = SetList.find(@params['id'])
    if @setlist
      render :action => :show
    else
      redirect :action => :index
    end
  end

  # GET /SetList/new
  def new
    @setlist = SetList.new
    render :action => :new
  end

  # GET /SetList/{1}/edit
  def edit
    @setlist = SetList.find(@params['id'])
    if @setlist
      render :action => :edit
    else
      redirect :action => :index
    end
  end

  # POST /SetList/create
  def create
    @setlist = SetList.new(@params['setlist'])
    @setlist.save
    redirect :action => :index
  end

  # POST /SetList/{1}/update
  def update
    @setlist = SetList.find(@params['id'])
    @setlist.update_attributes(@params['setlist']) if @setlist
    redirect :action => :index
  end

  # POST /SetList/{1}/delete
  def delete
    @setlist = SetList.find(@params['id'])
    @setlist.destroy if @setlist
    redirect :action => :index
  end
end
