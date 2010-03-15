require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'

class SettingsController < Rho::RhoController

  def index
    @msg = @params['msg']
    render
  end

  def about
    render
  end

  def logout
    SyncEngine.logout
    @msg = "You have been logged out."
    render :action => :login, :query => {:msg => @msg}
  end

  def reset
    render :action => :reset
  end

  def do_reset
    Rhom::Rhom.database_full_reset
    SyncEngine.dosync
    @msg = "Database has been reset."
    redirect :action => :index, :query => {:msg => @msg}
  end

  def do_sync
    SyncEngine.dosync
    @msg =  "Sync has been triggered."
    redirect :action => :index, :query => {:msg => @msg}
  end

  def sync_object_notify
    #do something with notification data
    WebView.refresh
  end
end
