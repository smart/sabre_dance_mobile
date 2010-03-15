require 'base_controller'
class TourController < BaseController

  #GET /Tour
  def index
    toolbar("Tours", :back => "Back")
    @tours = Tour.find(:all, :order => "first_show_date", :orderdir => "desc")
    render
  end

  # GET /Tour/{1}
  def show
    @tour = Tour.find(@params['id'])
    toolbar(@tour.name, :back => "Back")
    render :action => :show
  end

end
