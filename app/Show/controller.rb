require 'base_controller'
require 'net/http'
class ShowController < BaseController

  #GET /Show
  def index
    toolbar("Shows", :back => "Back")
    @shows = Show.find(:all, :limit => 100)
    render
  end

  def main
    toolbar("Set Lists and Songs", :back => "Back")
    render
  end

  def upcoming
    @shows = Show.find(:all, :order => "date", :conditions => "date(date) >= date('#{Date.today.to_s}')")
    toolbar("Upcoming Shows", :back => "Back")
    render :action => "index"
  end

  def recent
    @shows = Show.find(:all, :order => "date", :orderdir => "DESC", :per_page => 25, :conditions => "date(date) < date('#{Date.today.to_s}')")
    toolbar("Recent Shows", :back => "Back")
    render :action => "index"
  end

  def year
    p @params["id"]
    p strip_braces(@params["id"])
    year = strip_braces(@params["id"]).to_i
    p "something"
    p year
    next_year = year + 1
    @shows = Show.find(:all, :order => "date", :conditions => "date(date) < date('#{next_year}-01-01') AND date(date) >= date('#{year}-01-01')")
    toolbar("#{year} Shows", :back => "Back")
    render :action => "index"
  end

  def years
    toolbar("Years", :back => "Back")
    render
  end

  # GET /Show/{1}
  def show
    @show =  Show.find(@params['id'])
    toolbar(@show.date, :back => "Back")
    render :action => :show
  end

  def set_list
    @show =  Show.find(@params['id'])
    toolbar(@show.date, :back => "Back")
    render
  end

  # GET /Show/new
  def new_request
    @show = Show.new
    render :action => :new
  end

  def song_request
    @show = Show.find(@params['id'])
    @songs = Song.find(:all)
    render
  end

  def create_song_request
    res = Net::HTTP.post_form(URI.parse('http://sabre-dance.heroku.com/fan_requests'),
                                 {'song_id'=> strip_braces(@params["fan_request"]['song_id']), 'show_id' => strip_braces(@params['fan_request']['show_id']),
                                   'requested_by' => @params["fan_request"]['requested_by'], 'notes' => @params["fan_request"]['notes']})
    if res.code.to_i == 200
      Alert.show_popup "Some message"
      Alert.vibrate(1000)
    else
      Alert.show_popup "An error occured trying to submit your request"
      Alert.vibrate(1000)
    end
    render :string => "ok"
  end


end


