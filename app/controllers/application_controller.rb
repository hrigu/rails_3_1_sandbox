class ApplicationController < ActionController::Base

clear_helpers
  ##
  #  layout: see  doc/guides/layouts_and_rendering: see 2.2.12 Finding Layouts
  # by default, the layout is views/layouts/<ControllerName>.
  # or you can specifiy  it like this
  # layout "application"
  #
  ##


  protect_from_forgery


  ##
  # This method is the horse of rails
  ##
  def render(*args)
    super *args
  end


end
