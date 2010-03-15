require 'base_controller'
class DashboardController < BaseController


  def index
    toolbar("The Disco Biscuits - Dashboard")

    @last_show = Show.find(:first, :order => "date", :orderdir => "DESC", :conditions => "date(date) < date('#{Date.today.to_s}')")

    if @last_show.nil?
      unless $sync_in_progress
        $sync_in_progress = true
        SyncEngine.dosync
        p "starting sync"
      end
      Show.set_notification('/app/Dashboard/sync_notification', 'sync_complete=true')
      render :action => :ok
    else
      @upcoming_show = Show.find(:first, :order => "date", :conditions => "date(date) >= date('#{Date.today.to_s}')")
      render
    end
  end

  def login_required
    unless SyncEngine::logged_in > 0
      SyncEngine.login("biscuits", "venthor", (url_for :action => :login_callback) )
    end
  end

  def load
    login_required
    #@@toolbar = nil
    NativeBar.create(2, [])
    WebView.navigate("/app/Dashboard")
  end

  def login_callback
    errCode = @params['error_code'].to_i
    if errCode == 0
      # run sync if we were successful
      WebView.navigate Rho::RhoConfig.start_path
      SyncEngine.dosync
    else
      if errCode == Rho::RhoError::ERR_CUSTOMSYNCSERVER
        @msg = @params['error_message']
      end

      if !@msg || @msg.length == 0
        @msg = Rho::RhoError.new(errCode).message
      end

      WebView.navigate( url_for :action => :failed_login, :query => {:msg => @msg} )
    end
  end

  def load_db
    Rho::RhoUtils.load_offline_data(['object_values'])
    render
  end


  def sync_notification
    p "sync notification called"
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