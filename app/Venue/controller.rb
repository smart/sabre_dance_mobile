require 'rho/rhocontroller'
require 'helpers/show_helper'
class VenueController < Rho::RhoController
  include ShowHelper

  #GET /Venue
  def index
    @venues = Venuer.find(:all)
    render
  end

  # GET /Venue/{1}
  def show
    @venue = Venuer.find(@params['id'])
    render :action => :show
  end

  def map
    @venue = Venuer.find(@params['id'])
     #pin color
     map_params = {
          :settings => {:map_type => "hybrid",:region => [@venue.lat, @venue.lng, 0.2, 0.2],
                        :zoom_enabled => true,:scroll_enabled => true,:shows_user_location => false},
          :annotations => [{:latitude => @venue.lat, :longitude => @venue.lng, :street_address => @venue.street_address, :title => @venue.name, :subtitle => ""},
                           {:street_address => "Cupertino, CA 95014", :title => "Cupertino", :subtitle => "zip: 95014", :url => "/app/GeoLocation/show?city=Cupertino"},
                           {:street_address => "Santa Clara, CA 95051", :title => "Santa Clara", :subtitle => "zip: 95051", :url => "/app/GeoLocation/show?city=Santa%20Clara"}]
     }
     puts map_params.inspect
     MapView.create map_params
    render :action => :show
  end

  # GET /Venue/new
  def new
    @venue = Venue.new
    render :action => :new
  end

  # GET /Venue/{1}/edit
  def edit
    @venue = Venue.find(@params['id'])
    render :action => :edit
  end

  # POST /Venue/create
  def create
    @venue = Venue.new(@params['venue'])
    @venue.save
    redirect :action => :index
  end

  # POST /Venue/{1}/update
  def update
    @venue = Venue.find(@params['id'])
    @venue.update_attributes(@params['venue'])
    redirect :action => :index
  end

  # POST /Venue/{1}/delete
  def delete
    @venue = Venue.find(@params['id'])
    @venue.destroy
    redirect :action => :index
  end
end
