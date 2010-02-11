module ShowHelper


  def display_show(show)
    "#{show.date}" + (show.venue ? " #{show.venue.name}, #{show.venue.city} #{show.venue.state}" : "")
  end

  def display_song_performance(sp)
    return sp.inspect
    (sp.inverted? ? "<b>[X] </b>" : "") + "#{sp.song_name}#{sp.segue? ? " >" : ","}" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"font-size: 75%;\">" + (sp.tag_list.reject{|de| de =~ /nvert/} + [sp.notes]).compact.join(", &nbsp;") +  "</span>"
  end

  def venue_address(venue)
    if venue.street1
      "#{venue.street1} " + (venue.street2 && "#{venue.street2} " ) + "#{venue.city} #{venue.state}, #{venue.zip}"
    else
      "#{venue.city} #{venue.state}"
    end
  end
end