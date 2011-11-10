#http://net.tutsplus.com/tutorials/javascript-ajax/using-unobtrusive-javascript-and-ajax-with-rails-3/
class AjaxController < ApplicationController

  def index
  end

  def clear
    respond_to do |format|
      format.js   {render }
    end

  end

  def invoke
    p params[:put]
    @message = params[:put][:message]
    respond_to do |format|
      format.html { render }
      format.js
    end

  end

end
