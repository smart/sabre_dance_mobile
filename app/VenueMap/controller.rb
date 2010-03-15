class VenueMapController < Rho::RhoController
  @layout = 'VenueMap/layout'

  # GET /Venue/{1}
  def show
    @venue = Venue.find(@params['id'])
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

end
