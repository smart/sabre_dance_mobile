class PhotoAlbum

  def photos
    @photos ||= JSON.parse( photos_json.unpack("m").first || "[]")
  end

end