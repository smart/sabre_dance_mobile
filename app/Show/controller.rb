require 'rho/rhocontroller'
require 'helpers/show_helper'
class ShowController < Rho::RhoController
   include ShowHelper
  #GET /Show
  def index
    @shows = Showr.find(:all)
    render
  end

  def main
    render
  end


  # GET /Show/{1}
  def show
    @show =  Showr.find(@params['id'])
    #raise SongPerformancer.find(:all).inspect
    @venue = @show.venue
    render :action => :show
  end

  # GET /Show/new
  def new
    @show = Show.new
    render :action => :new
  end

  # GET /Show/{1}/edit
  def edit
    @show = Show.find(@params['id'])
    render :action => :edit
  end

  # POST /Show/create
  def create
    @show = Show.new(@params['show'])
    @show.save
    redirect :action => :index
  end

  # POST /Show/{1}/update
  def update
    @show = Show.find(@params['id'])
    @show.update_attributes(@params['show'])
    redirect :action => :index
  end

  # POST /Show/{1}/delete
  def delete
    @show = Show.find(@params['id'])
    @show.destroy
    redirect :action => :index
  end
end


