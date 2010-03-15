class SongPerformance #< ActiveRhom
  attr_accessor :segue, :song_id, :song_name, :inverted, :notes, :tag_list_string, :display_str

  def initialize(song_performance)
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
     @song ||= Song.find(song_id)
   end

   def tag_list
     tag_list_string ? tag_list_string.split("#;") : []
   end

end