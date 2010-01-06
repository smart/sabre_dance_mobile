require 'rho/rhocontroller'
require 'helpers/show_helper'
require 'date'
require 'rho/rhoutils'
require 'rhom'
class DashboardController < Rho::RhoController
  include ShowHelper
  #GET /Dashboard
  def index
    @upcoming_show = Showr.find(:first, :order => "date", :conditions => "date(date) >= date('#{Date.today.to_s}')")
    @last_show = Showr.find(:first, :order => "date", :orderdir => "DESC", :conditions => "date(date) < date('#{Date.today.to_s}')")
=begin
    if @last_show.nil?
      @loading = true
      Rho::RhoUtils.load_offline_data(['object_values'])
    end
=end
    render
  end

  def load_db
    Rho::RhoUtils.load_offline_data(['object_values'])
    render
  end



end