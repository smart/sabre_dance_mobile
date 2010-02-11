require 'rho/rhocontroller'
require 'helpers/show_helper'
require 'date'
require 'rho/rhoutils'
require 'rhom'
class DashboardController < Rho::RhoController
  include ShowHelper
  #GET /Dashboard


  def ok
    render :action => :ok
  end

  def index
    check_db
    @last_show = Showr.find(:first, :order => "date", :orderdir => "DESC", :conditions => "date(date) < date('#{Date.today.to_s}')")
    if @last_show.nil?
      unless $sync_in_progress
        $sync_in_progress = true
        SyncEngine.dosync
      end
      #Show.set_notification('/app/Dashboard/sync_notification', 'sync_complete=true')
      render :action => :ok
    else
      @upcoming_show = Showr.find(:first, :order => "date", :conditions => "date(date) >= date('#{Date.today.to_s}')")
      render
    end
  end

  def check_db
    unless SyncEngine::logged_in > 0
      SyncEngine.login("biscuits", "venthor", (url_for :action => :login_callback) )
      #Rho::RhoUtils.load_offline_data(['object_values'])
    end
  end

  def load_db
    Rho::RhoUtils.load_offline_data(['object_values'])
    render
  end


  def sync_notification
    status = @params['status'] ? @params['status'] : ""
    if status == "error"
      errCode = @params['error_code'].to_i
      if errCode == Rho::RhoError::ERR_CUSTOMSYNCSERVER
        @msg = @params['error_message']
      else
        @msg = Rho::RhoError.new(errCode).message
      end

      WebView.navigate(url_for(:action => :index, :query => {:msg => @msg}))
    elsif status == "ok"
      if SyncEngine::logged_in > 0
        $sync_in_progress = false
        WebView.navigate(url_for(:action => :index))
      else
        # rhosync has logged us out
        WebView.navigate "/app/Settings/login"
      end
    end
  end



end