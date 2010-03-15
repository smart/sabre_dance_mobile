require 'SetList/set_list'
class Show

  def venue
    @venue ||=  Venue.find(venue_id)
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
    @song_performances ||= SongPerformance.find(:all, :conditions => {:show_id => strip_braces(object)})
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

  def photo_albums
    @photo_albums ||= (PhotoAlbum.find(:all, :conditions => {:show_id => strip_braces(object)}, :order => "date", :orderdir => "DESC") || [])
  end

  def photos
    photo_albums.collect{|pa| pa.photos }.flatten
  end

  def videos
    []
  end

  def buy_tickets_link
    "http://www.google.com"
  end

end