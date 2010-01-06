require 'rho/rhocontroller'

class SongPerformanceController < Rho::RhoController

  #GET /SongPerformance
  def index
    @songperformances = SongPerformance.find(:all)
    render
  end

  # GET /SongPerformance/{1}
  def show
    @songperformance = SongPerformance.find(@params['id'])
    if @songperformance
      render :action => :show
    else
      redirect :action => :index
    end
  end

  # GET /SongPerformance/new
  def new
    @songperformance = SongPerformance.new
    render :action => :new
  end

  # GET /SongPerformance/{1}/edit
  def edit
    @songperformance = SongPerformance.find(@params['id'])
    if @songperformance
      render :action => :edit
    else
      redirect :action => :index
    end
  end

  # POST /SongPerformance/create
  def create
    @songperformance = SongPerformance.new(@params['songperformance'])
    @songperformance.save
    redirect :action => :index
  end

  # POST /SongPerformance/{1}/update
  def update
    @songperformance = SongPerformance.find(@params['id'])
    @songperformance.update_attributes(@params['songperformance']) if @songperformance
    redirect :action => :index
  end

  # POST /SongPerformance/{1}/delete
  def delete
    @songperformance = SongPerformance.find(@params['id'])
    @songperformance.destroy if @songperformance
    redirect :action => :index
  end
end
