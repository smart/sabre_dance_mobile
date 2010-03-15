class Venue

  def street_address
    "#{street1}, #{city}, #{state} #{zip}"
  end

  def shows
    @shows ||= Show.find(:all, :conditions => {:venue_id => strip_braces(object)}, :order => "date", :orderdir => "DESC")
  end

  def photo_albums
    @photo_albums ||= PhotoAlbum.find(:all, :conditions => {:venue_id => strip_braces(object)}, :order => "date", :orderdir => "DESC")
  end

  def photos
    photo_albums.collect{|pa| pa.photos }.flatten
  end

end