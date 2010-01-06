require 'rho/rhoapplication'
require 'rho/rhoutils'
require 'rhom'
require 'json'

class AppApplication < Rho::RhoApplication
  def initialize
      # Tab items are loaded left->right, @tabs[0] is leftmost tab in the tab-bar
      @tabs = [{ :label => "Dashboard", :action => '/app/Dashboard', :icon => "/public/images/right_button.png", :reload => true },
               { :label => "Songs/Sets", :action => '/app/Show/main', :icon => "/public/images/right_button.png" },
               { :label => "Media", :action => '/app/Media', :icon => "/public/images/right_button.png" },
               { :label =>  "News", :action => 'http://www.discobiscuits.com/2/', :icon => "/public/images/right_button.png" },
               { :label => "Options", :action => '/app/Settings', :icon => "/public/images/right_button.png" }]
      # Important to call super _after_ you define @tabs!
      #Rho::RhoUtils.load_offline_data(['object_values'])
      super
    end
end


class ActiveRhom
  def strip_braces(str=nil)
    str ? str.gsub(/\{/,"").gsub(/\}/,"") : nil
  end

  def self.rhom_class_name
    self.class.to_s[0..-2]
  end

  def self.rhom_class
    rhom_class_name.constantize
  end

  def self.find(*args)
    found = rhom_class.find(*args)
    return nil if found.nil?
    return found.collect{|fd| new(fd) } if found.is_a?(Array)
    return new(found)
  end

  def initialize(rhom_object)
    @rhom = rhom_object
  end

  def method_missing(name)
    @rhom.send(name)
  end

  def id
    strip_braces(@rhom.id)
  end

  def rhom_id
    @rhom.id
  end

end

class Tourr < ActiveRhom

  def self.rhom_class
    Tour
  end

  def shows
    @shows ||= Showr.find(:all, :conditions => {:tour_id => strip_braces(object)}, :order => "date", :orderdir => "DESC")
  end
end

class Showr < ActiveRhom

  def self.rhom_class
    Show
  end

  def venue
    @venue ||=  Venuer.find(venue_id)
  end

  def the_set_list
    @the_set_list ||= JSON.parse( set_list_json.unpack("m").first || "{}")
  end

  def set_lists
    @set_lists ||= the_set_list.collect{|set| SetList.new(set)}
  end

  def upcoming?
    Date.parse(date) >= Date.today
  end

  def song_performances
    @song_performances ||= SongPerformancer.find(:all, :conditions => {:show_id => strip_braces(object)})
  end

  def normalized_set_lists
    sl = {}
    song_performances.each do |element|
      key = element.set
      if sl.has_key?(key)
        sl[key] << element
      else
        sl[key] = [element]
      end
    end
    p "DOES THIS COME OUT?"
    sets = []
    sl.each {|key, value| sets << SetList.new(key, value)}
    sets
  end

end


class SetListSync
  attr_accessor :song_performances, :position, :name
  def initialize(position, set_list)
    @song_performances = set_list.sort{|x,y| x.position.to_i <=> y.position.to_i }
    @position = position
  end

  def name
    "Set #{position}:"
  end

end

class Venuer < ActiveRhom

  def self.rhom_class
    Venue
  end

  def street_address
    "#{street1}, #{city}, #{state} #{zip}"
  end

  def shows
    @shows ||= Showr.find(:all, :conditions => {:venue_id => strip_braces(object)}, :order => "date", :orderdir => "DESC")
  end
end



class SetList
  attr_accessor :song_performances, :position, :name
  def initialize(set_list)
    p "Creating set list"
    p set_list
    @song_performances = set_list["song_performances"].collect{|sp| SongPerformance.new(sp)}
    @position = set_list["position"]
    @name = set_list["name"]
  end

end


class SongPerformance< ActiveRhom
  attr_accessor :segue, :song_id, :song_name, :inverted, :notes, :tag_list_string, :display_str

  def initialize(song_performance)
    p "creating song performance"
    p song_performance
    p "created"
    @segue = (song_performance["segue"] == true || song_performance["segue"] == "true") ? true : false
    @song_id = song_performance["song_id"]
    @song_name = song_performance["song_name"]
    @inverted = (song_performance["inverted"] == true || song_performance["inverted"] == "true") ? true : false
    @notes = song_performance["notes"]
    @tag_list_string = song_performance["tag_list_string"]
    @display_str = song_performance["display_str"]
  end

  def inverted?
    inverted
  end

  def segue?
    segue
  end

  def song
     @song ||= Songr.find(song_id)
   end

   def tag_list
     tag_list_string ? tag_list_string.split("#;") : []
   end

end



class SongPerformancer < ActiveRhom


  def self.rhom_class
    SongPerformance
  end


  def inverted?
    split_info[3] == "1" ? true : false
  end

  def split_info
    @split_info = info.split("%^")
  end

  def set
    split_info[0]
  end

  def position
    split_info[1]
  end

  def segue?
    split_info[2] == "1" ? true : false
  end

  def notes
    split_info[3]
  end

  def tag_list_string
    split_info[4]
  end

  def song
    @song ||= Songr.find(song_id)
  end

  def tag_list
    tag_list_string ? tag_list_string.split("#;") : []
  end

end

class Songr < ActiveRhom

  def self.rhom_class
    Song
  end

  def original?
    original == "true" ? true : false
  end

end