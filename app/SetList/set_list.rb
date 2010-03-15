require 'SongPerformance/song_performance'


class SetList

  attr_accessor :song_performances, :position, :name
  def initialize(set_list)
    p "Creating set list"
    p set_list
    @song_performances = set_list["song_performances"].collect{|sp| SongPerformance.new(sp)}
    p @song_performances
    @position = set_list["position"]
    @name = set_list["name"]
  end
end