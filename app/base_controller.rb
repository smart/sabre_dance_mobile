require 'rho/rhocontroller'
require 'helpers/application_helper'
require 'helpers/show_helper'
require 'date'
require 'rho/rhoutils'
require 'rhom'
class BaseController < Rho::RhoController
  include ApplicationHelper
  include ShowHelper

  def ok
    render :action => :ok
  end

  protected

  def toolbar(title, opts = {})
    str = "<div class=\"toolbar\">"
    str += "  <a class=\"back\">#{opts[:back]}</a>" if opts[:back]
    str += "  <h1 id=\"pageTitle\">#{title}</h1>"
    str += "</div>"
    @toolbar = str
  end

end