require 'rho/rhocontroller'
require 'helpers/show_helper'
class TourController < Rho::RhoController
 include ShowHelper
  #GET /Tour
  def index
    @tours = Tourr.find(:all, :order => "first_show_date", :orderdir => "desc")
    render
  end

  # GET /Tour/{1}
  def show
    #@tour = Tour.find(@params['id'])
    #redirect :controller => "Song", :action => :index, :query => {:query => @tour.object}

    @tour = Tourr.find(@params['id'])
    render :action => :show
  end

  # GET /Tour/new
  def new
    @tour = Tour.new
    render :action => :new
  end

  # GET /Tour/{1}/edit
  def edit
    @tour = Tour.find(@params['id'])
    render :action => :edit
  end

  # POST /Tour/create
  def create
    @tour = Tour.new(@params['tour'])
    @tour.save
    redirect :action => :index
  end

  # POST /Tour/{1}/update
  def update
    @tour = Tour.find(@params['id'])
    @tour.update_attributes(@params['tour'])
    redirect :action => :index
  end

  # POST /Tour/{1}/delete
  def delete
    @tour = Tour.find(@params['id'])
    @tour.destroy
    redirect :action => :index
  end
end
