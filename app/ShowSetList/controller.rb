require 'rho/rhocontroller'

class ShowSetListController < Rho::RhoController

  #GET /ShowSetList
  def index
    @showsetlists = ShowSetList.find(:all)
    render
  end

  # GET /ShowSetList/{1}
  def show
    @showsetlist = ShowSetList.find(@params['id'])
    if @showsetlist
      render :action => :show
    else
      redirect :action => :index
    end
  end

  # GET /ShowSetList/new
  def new
    @showsetlist = ShowSetList.new
    render :action => :new
  end

  # GET /ShowSetList/{1}/edit
  def edit
    @showsetlist = ShowSetList.find(@params['id'])
    if @showsetlist
      render :action => :edit
    else
      redirect :action => :index
    end
  end

  # POST /ShowSetList/create
  def create
    @showsetlist = ShowSetList.new(@params['showsetlist'])
    @showsetlist.save
    redirect :action => :index
  end

  # POST /ShowSetList/{1}/update
  def update
    @showsetlist = ShowSetList.find(@params['id'])
    @showsetlist.update_attributes(@params['showsetlist']) if @showsetlist
    redirect :action => :index
  end

  # POST /ShowSetList/{1}/delete
  def delete
    @showsetlist = ShowSetList.find(@params['id'])
    @showsetlist.destroy if @showsetlist
    redirect :action => :index
  end
end
