class Tour

  def shows
    @shows ||= Show.find(:all, :conditions => {:tour_id => strip_braces(object)}, :order => "date", :orderdir => "DESC")
  end

end