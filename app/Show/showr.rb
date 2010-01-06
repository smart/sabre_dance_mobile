class Showr

  def initialize(show)
    @show = show
  end

  def self.find(id)
    show = Show.find(@params['id'])
    new(show)
  end

  def venue
    @venue ||=  Venue.find(show.venue_id)
  end

end